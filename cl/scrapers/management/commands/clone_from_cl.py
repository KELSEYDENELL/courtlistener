"""
This tool allows you to partially clone data from courtlistener.com to your
local environment, you only need to pass the type and object id and run it.

manage.py clone_from_cl --type Opinion --id 9355884
manage.py clone_from_cl --type Docket --id 5377675
manage.py clone_from_cl --type Person --id 16207
manage.py clone_from_cl --type Court --id usnmcmilrev

This tool is only for development purposes, so it only works when
the DEVELOPMENT env is set to True. It also relies on the CL_API_TOKEN
env variable.

This is still work in progress, some data is not cloned yet.
"""

import os
import sys

import requests
from django.apps import apps
from django.conf import settings
from django.db import transaction
from django.urls import reverse
from django.utils.dateparse import parse_date

from cl.lib.command_utils import VerboseCommand
from cl.search.models import Citation, Docket, Opinion
from cl.search.tasks import add_items_to_solr

VALID_TYPES = (
    "search.OpinionCluster", "search.Docket", "people_db.Person",
    "search.Court")

cluster_endpoint = "https://www.courtlistener.com/api/rest/v3/clusters/"
people_endpoint = "https://www.courtlistener.com/api/rest/v3/people/"
courts_endpoint = "https://www.courtlistener.com/api/rest/v3/courts/"


class Command(VerboseCommand):
    help = "Clone data from CourtListener.com into dev environment"

    def __init__(self, *args, **kwargs):
        super(Command, self).__init__(*args, **kwargs)
        self.options = []
        self.type = None

        self.s = requests.session()
        self.s.headers = {
            "Authorization": f"Token {os.environ.get('CL_API_TOKEN', '')}"
        }

    def add_arguments(self, parser):
        parser.add_argument(
            "--type",
            type=str,
            choices=VALID_TYPES,
            help="Object type to clone. Current choices are %s"
                 % ", ".join(VALID_TYPES),
        )

        parser.add_argument(
            "--id",
            help="Object id, " "object id to clone",
        )

    def handle(self, *args, **options):
        super(Command, self).handle(*args, **options)
        self.type = options.get("type")
        self.id = options.get("id")

        if not self.id:
            self.stdout.write("Object id required!")
            sys.exit(1)

        if settings.DEVELOPMENT:
            if self.type == "search.OpinionCluster":
                self.clone_opinion_cluster(self.id)
            elif self.type == "search.Docket":
                self.clone_docket(self.id, self.type)
            elif self.type == "people_db.Person":
                self.clone_person(self.id, self.type)
            elif self.type == "search.Court":
                self.clone_court(self.id, self.type)
            else:
                self.stdout.write("Invalid type!")

        else:
            self.stdout.write("Command not enabled for production environment")

    def clone_opinion_cluster(self, cluster_id) -> None:
        """Download opinion cluster data from courtlistener.com and add it to
        local environment
        """

        model = apps.get_model(self.type)

        try:
            obj = model.objects.get(pk=cluster_id)
            print(
                f"OpinionCluster with id: {cluster_id} already in local env."
            )
            return
        except model.DoesNotExist:

            cluster_url = f"{cluster_endpoint}{cluster_id}/"
            results = self.s.get(cluster_url).json()
            cluster_datum = results
            docket_id = cluster_datum["docket"].split("/")[7]
            docket = self.clone_docket(docket_id)
            citation_data = cluster_datum["citations"]
            sub_opinions_data = cluster_datum["sub_opinions"]
            # delete resource_uri value generated by DRF
            del cluster_datum["resource_uri"]
            # delete fields with fk or m2m relations or unneeded fields
            del cluster_datum["docket"]
            del cluster_datum["citations"]
            del cluster_datum["sub_opinions"]
            del cluster_datum["absolute_url"]
            del cluster_datum["panel"]
            del cluster_datum["non_participating_judges"]

            # Assign docket pk in cluster data
            cluster_datum["docket_id"] = docket.pk

            prepared_opinion_data = []
            added_opinions_ids = []

            for op in sub_opinions_data:
                # Get opinion from api
                op_data = self.s.get(op).json()
                # Delete fields with fk or m2m relations or unneeded fields
                del op_data["opinions_cited"]
                del op_data["cluster"]
                del op_data["absolute_url"]
                del op_data["resource_uri"]
                del op_data["author"]
                del op_data["joined_by"]
                # Append new data
                prepared_opinion_data.append(op_data)

            with transaction.atomic():
                # Create opinion cluster
                opinion_cluster = model.objects.create(
                    **cluster_datum
                )

                for cite_data in citation_data:
                    # Create citations
                    cite_data["cluster_id"] = opinion_cluster.pk
                    Citation.objects.create(**cite_data)

                for opinion_data in prepared_opinion_data:
                    # Update cluster_id in opinion's json
                    opinion_data["cluster_id"] = opinion_cluster.pk

                    # Create opinion
                    op = Opinion.objects.create(**opinion_data)

                    # Store created opinion id
                    added_opinions_ids.append(op.id)

                print(
                    ">> View cloned case here:",
                    reverse(
                        "view_case", args=[opinion_cluster.pk, docket.slug]
                    ),
                )

            # Add opinions to search engine
            add_items_to_solr.delay(added_opinions_ids, "search.Opinion")

    def clone_docket(self, docket_id, type="search.Docket") -> [Docket, None]:
        """
        Download docket data from courtlistener.com and add it to local
        environment
        :param docket_id: Docket id
        :param type: Docket app name with model name
        :return: Docket object
        """

        model = apps.get_model(type)

        try:
            obj = model.objects.get(pk=docket_id)
            print(f"Docket with id: {docket_id} already in local env.")
            return obj
        except model.DoesNotExist:
            # Create new Docket

            docket_endpoint = f"https://www.courtlistener.com/api/rest/v3/dockets/{docket_id}/"
            docket_data = self.s.get(docket_endpoint).json()

            # Remove unneeded fields
            del docket_data["resource_uri"]
            del docket_data["original_court_info"]
            del docket_data["absolute_url"]
            # TODO helpers to create other objects and set m2m relations
            del docket_data["clusters"]
            del docket_data["audio_files"]
            del docket_data["tags"]
            del docket_data["panel"]
            # del docket_data["assigned_to"]

            with transaction.atomic():

                # Get or create required objects
                docket_data["court"] = (
                    self.clone_court(docket_data["court"].split("/")[7])
                    if docket_data["court"]
                    else None
                )

                docket_data["appeal_from"] = (
                    self.clone_court(docket_data["appeal_from"].split("/")[7])
                    if docket_data["appeal_from"]
                    else None
                )

                docket_data["assigned_to"] = (
                    self.clone_person(docket_data["assigned_to"].split("/")[7])
                    if docket_data["assigned_to"]
                    else None
                )

                docket = model.objects.create(**docket_data)
                print(
                    ">> View cloned docket here:",
                    reverse(
                        "view_docket",
                        args=[docket_data["id"], docket_data["slug"]],
                    ),
                )
                return docket

    def clone_person(self, person_id, type="people_db.Person"):
        """
        Download person data from courtlistener.com and add it to local
        environment
        :param person_id: Person id
        :param type: Person app name with model name
        :return: Person object
        """

        model = apps.get_model(type)

        try:
            person = model.objects.get(pk=person_id)
        except model.DoesNotExist:

            person_url = f"{people_endpoint}{person_id}/"

            person_data = self.s.get(person_url).json()
            # delete resource_uri value generated by DRF
            del person_data["resource_uri"]
            # delete fields with fk or m2m relations or unneeded fields
            # TODO create helpers to build that objects
            del person_data["aba_ratings"]
            del person_data["race"]
            del person_data["sources"]
            del person_data["educations"]
            del person_data["positions"]
            del person_data["political_affiliations"]
            # Prepare some values
            if person_data["date_dob"]:
                person_data["date_dob"] = parse_date(person_data["date_dob"])
            try:
                person, created = model.objects.get_or_create(**person_data)
            except:
                person = model.objects.filter(pk=person_data["id"])[0]

        print(
            ">> View cloned person here:",
            reverse("person-detail", args=["v3", person_id]),
        )
        return person

    def clone_court(self, court_id, type="search.Court"):
        """
        Download court data from courtlistener.com and add it to local
        environment
        :param court_id: Court id
        :param type: Court app name with model name
        :return: Court object
        """

        model = apps.get_model(type)

        try:
            ct = model.objects.get(pk=court_id)
        except model.DoesNotExist:
            court_url = f"{courts_endpoint}{court_id}/"

            court_data = self.s.get(court_url).json()
            # delete resource_uri value generated by DRF
            del court_data["resource_uri"]

            try:
                ct = model.objects.get_or_create(**court_data)
            except:
                ct = model.objects.filter(pk=court_data["id"])[0]

        print(
            ">> View cloned court here:",
            reverse("court-detail", args=["v3", court_id]),
        )
        return ct
