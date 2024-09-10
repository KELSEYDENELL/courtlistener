BEGIN;
--
-- Remove trigger update_or_delete_snapshot_update from model bankruptcyinformation
--
DROP TRIGGER IF EXISTS pgtrigger_update_or_delete_snapshot_update_17e86 ON "search_bankruptcyinformation";
--
-- Remove trigger update_or_delete_snapshot_update from model claim
--
DROP TRIGGER IF EXISTS pgtrigger_update_or_delete_snapshot_update_bb32f ON "search_claim";
--
-- Remove trigger update_or_delete_snapshot_update from model claimhistory
--
DROP TRIGGER IF EXISTS pgtrigger_update_or_delete_snapshot_update_137a5 ON "search_claimhistory";
--
-- Remove trigger update_or_delete_snapshot_update from model court
--
DROP TRIGGER IF EXISTS pgtrigger_update_or_delete_snapshot_update_c94ab ON "search_court";
--
-- Remove trigger update_or_delete_snapshot_update from model docket
--
DROP TRIGGER IF EXISTS pgtrigger_update_or_delete_snapshot_update_7e039 ON "search_docket";
--
-- Remove trigger update_or_delete_snapshot_update from model docketentry
--
DROP TRIGGER IF EXISTS pgtrigger_update_or_delete_snapshot_update_46e1e ON "search_docketentry";
--
-- Remove trigger update_or_delete_snapshot_update from model opinion
--
DROP TRIGGER IF EXISTS pgtrigger_update_or_delete_snapshot_update_67ecd ON "search_opinion";
--
-- Remove trigger update_or_delete_snapshot_update from model opinioncluster
--
DROP TRIGGER IF EXISTS pgtrigger_update_or_delete_snapshot_update_6a181 ON "search_opinioncluster";
--
-- Remove trigger update_or_delete_snapshot_update from model originatingcourtinformation
--
DROP TRIGGER IF EXISTS pgtrigger_update_or_delete_snapshot_update_49538 ON "search_originatingcourtinformation";
--
-- Remove trigger update_or_delete_snapshot_update from model recapdocument
--
DROP TRIGGER IF EXISTS pgtrigger_update_or_delete_snapshot_update_8a108 ON "search_recapdocument";
--
-- Remove trigger update_or_delete_snapshot_update from model tag
--
DROP TRIGGER IF EXISTS pgtrigger_update_or_delete_snapshot_update_c9dd9 ON "search_tag";
--
-- Rename unnamed index for ('volume', 'reporter') on citation to search_citation_volume_251bc1d270a8abee_idx
--
ALTER INDEX "search_cita_volume_464334_idx" RENAME TO "search_citation_volume_251bc1d270a8abee_idx";
--
-- Rename unnamed index for ('volume', 'reporter', 'page') on citation to search_citation_volume_ae340b5b02e8912_idx
--
ALTER INDEX "search_cita_volume_92c344_idx" RENAME TO "search_citation_volume_ae340b5b02e8912_idx";
--
-- Rename unnamed index for ('recap_sequence_number', 'entry_number') on docketentry to search_docketentry_recap_sequence_number_1c82e51988e2d89f_idx
--
ALTER INDEX "search_dock_recap_s_306ab9_idx" RENAME TO "search_docketentry_recap_sequence_number_1c82e51988e2d89f_idx";
--
-- Rename unnamed index for ('document_type', 'document_number', 'attachment_number') on recapdocument to search_recapdocument_document_type_303cccac79571217_idx
--
ALTER INDEX "search_reca_documen_cc5acd_idx" RENAME TO "recapdocument to search_recapdocument_document_type_303cccac79571217_idx";
--
-- Create trigger update_or_delete_snapshot_update on model bankruptcyinformation
--

            CREATE OR REPLACE FUNCTION "public"._pgtrigger_should_ignore(
                trigger_name NAME
            )
            RETURNS BOOLEAN AS $$
                DECLARE
                    _pgtrigger_ignore TEXT[];
                    _result BOOLEAN;
                BEGIN
                    BEGIN
                        SELECT INTO _pgtrigger_ignore
                            CURRENT_SETTING('pgtrigger.ignore');
                        EXCEPTION WHEN OTHERS THEN
                    END;
                    IF _pgtrigger_ignore IS NOT NULL THEN
                        SELECT trigger_name = ANY(_pgtrigger_ignore)
                        INTO _result;
                        RETURN _result;
                    ELSE
                        RETURN FALSE;
                    END IF;
                END;
            $$ LANGUAGE plpgsql;

            CREATE OR REPLACE FUNCTION pgtrigger_update_or_delete_snapshot_update_17e86()
            RETURNS TRIGGER AS $$

                BEGIN
                    IF ("public"._pgtrigger_should_ignore(TG_NAME) IS TRUE) THEN
                        IF (TG_OP = 'DELETE') THEN
                            RETURN OLD;
                        ELSE
                            RETURN NEW;
                        END IF;
                    END IF;
                    INSERT INTO "search_bankruptcyinformationevent" ("chapter", "date_converted", "date_created", "date_debtor_dismissed", "date_last_to_file_claims", "date_last_to_file_govt", "date_modified", "docket_id", "id", "pgh_context_id", "pgh_created_at", "pgh_label", "pgh_obj_id", "trustee_str") VALUES (OLD."chapter", OLD."date_converted", OLD."date_created", OLD."date_debtor_dismissed", OLD."date_last_to_file_claims", OLD."date_last_to_file_govt", OLD."date_modified", OLD."docket_id", OLD."id", _pgh_attach_context(), NOW(), 'update_or_delete_snapshot', OLD."id", OLD."trustee_str"); RETURN NULL;
                END;
            $$ LANGUAGE plpgsql;

            DROP TRIGGER IF EXISTS pgtrigger_update_or_delete_snapshot_update_17e86 ON "search_bankruptcyinformation";
            CREATE  TRIGGER pgtrigger_update_or_delete_snapshot_update_17e86
                AFTER UPDATE ON "search_bankruptcyinformation"


                FOR EACH ROW WHEN (OLD."id" IS DISTINCT FROM (NEW."id") OR OLD."date_created" IS DISTINCT FROM (NEW."date_created") OR OLD."docket_id" IS DISTINCT FROM (NEW."docket_id") OR OLD."date_converted" IS DISTINCT FROM (NEW."date_converted") OR OLD."date_last_to_file_claims" IS DISTINCT FROM (NEW."date_last_to_file_claims") OR OLD."date_last_to_file_govt" IS DISTINCT FROM (NEW."date_last_to_file_govt") OR OLD."date_debtor_dismissed" IS DISTINCT FROM (NEW."date_debtor_dismissed") OR OLD."chapter" IS DISTINCT FROM (NEW."chapter") OR OLD."trustee_str" IS DISTINCT FROM (NEW."trustee_str"))
                EXECUTE PROCEDURE pgtrigger_update_or_delete_snapshot_update_17e86();

            COMMENT ON TRIGGER pgtrigger_update_or_delete_snapshot_update_17e86 ON "search_bankruptcyinformation" IS '85d1a7878d466326c90c68b401f107b1158c2796';

--
-- Create trigger update_or_delete_snapshot_update on model claim
--

            CREATE OR REPLACE FUNCTION "public"._pgtrigger_should_ignore(
                trigger_name NAME
            )
            RETURNS BOOLEAN AS $$
                DECLARE
                    _pgtrigger_ignore TEXT[];
                    _result BOOLEAN;
                BEGIN
                    BEGIN
                        SELECT INTO _pgtrigger_ignore
                            CURRENT_SETTING('pgtrigger.ignore');
                        EXCEPTION WHEN OTHERS THEN
                    END;
                    IF _pgtrigger_ignore IS NOT NULL THEN
                        SELECT trigger_name = ANY(_pgtrigger_ignore)
                        INTO _result;
                        RETURN _result;
                    ELSE
                        RETURN FALSE;
                    END IF;
                END;
            $$ LANGUAGE plpgsql;

            CREATE OR REPLACE FUNCTION pgtrigger_update_or_delete_snapshot_update_bb32f()
            RETURNS TRIGGER AS $$

                BEGIN
                    IF ("public"._pgtrigger_should_ignore(TG_NAME) IS TRUE) THEN
                        IF (TG_OP = 'DELETE') THEN
                            RETURN OLD;
                        ELSE
                            RETURN NEW;
                        END IF;
                    END IF;
                    INSERT INTO "search_claimevent" ("amount_claimed", "claim_number", "creditor_details", "creditor_id", "date_claim_modified", "date_created", "date_last_amendment_entered", "date_last_amendment_filed", "date_modified", "date_original_entered", "date_original_filed", "description", "docket_id", "entered_by", "filed_by", "id", "pgh_context_id", "pgh_created_at", "pgh_label", "pgh_obj_id", "priority_claimed", "remarks", "secured_claimed", "status", "unsecured_claimed") VALUES (OLD."amount_claimed", OLD."claim_number", OLD."creditor_details", OLD."creditor_id", OLD."date_claim_modified", OLD."date_created", OLD."date_last_amendment_entered", OLD."date_last_amendment_filed", OLD."date_modified", OLD."date_original_entered", OLD."date_original_filed", OLD."description", OLD."docket_id", OLD."entered_by", OLD."filed_by", OLD."id", _pgh_attach_context(), NOW(), 'update_or_delete_snapshot', OLD."id", OLD."priority_claimed", OLD."remarks", OLD."secured_claimed", OLD."status", OLD."unsecured_claimed"); RETURN NULL;
                END;
            $$ LANGUAGE plpgsql;

            DROP TRIGGER IF EXISTS pgtrigger_update_or_delete_snapshot_update_bb32f ON "search_claim";
            CREATE  TRIGGER pgtrigger_update_or_delete_snapshot_update_bb32f
                AFTER UPDATE ON "search_claim"


                FOR EACH ROW WHEN (OLD."id" IS DISTINCT FROM (NEW."id") OR OLD."date_created" IS DISTINCT FROM (NEW."date_created") OR OLD."docket_id" IS DISTINCT FROM (NEW."docket_id") OR OLD."date_claim_modified" IS DISTINCT FROM (NEW."date_claim_modified") OR OLD."date_original_entered" IS DISTINCT FROM (NEW."date_original_entered") OR OLD."date_original_filed" IS DISTINCT FROM (NEW."date_original_filed") OR OLD."date_last_amendment_entered" IS DISTINCT FROM (NEW."date_last_amendment_entered") OR OLD."date_last_amendment_filed" IS DISTINCT FROM (NEW."date_last_amendment_filed") OR OLD."claim_number" IS DISTINCT FROM (NEW."claim_number") OR OLD."creditor_details" IS DISTINCT FROM (NEW."creditor_details") OR OLD."creditor_id" IS DISTINCT FROM (NEW."creditor_id") OR OLD."status" IS DISTINCT FROM (NEW."status") OR OLD."entered_by" IS DISTINCT FROM (NEW."entered_by") OR OLD."filed_by" IS DISTINCT FROM (NEW."filed_by") OR OLD."amount_claimed" IS DISTINCT FROM (NEW."amount_claimed") OR OLD."unsecured_claimed" IS DISTINCT FROM (NEW."unsecured_claimed") OR OLD."secured_claimed" IS DISTINCT FROM (NEW."secured_claimed") OR OLD."priority_claimed" IS DISTINCT FROM (NEW."priority_claimed") OR OLD."description" IS DISTINCT FROM (NEW."description") OR OLD."remarks" IS DISTINCT FROM (NEW."remarks"))
                EXECUTE PROCEDURE pgtrigger_update_or_delete_snapshot_update_bb32f();

            COMMENT ON TRIGGER pgtrigger_update_or_delete_snapshot_update_bb32f ON "search_claim" IS '5a3fde0d49f7f04afe30f9151a8b3535710ec1a0';

--
-- Create trigger update_or_delete_snapshot_update on model claimhistory
--

            CREATE OR REPLACE FUNCTION "public"._pgtrigger_should_ignore(
                trigger_name NAME
            )
            RETURNS BOOLEAN AS $$
                DECLARE
                    _pgtrigger_ignore TEXT[];
                    _result BOOLEAN;
                BEGIN
                    BEGIN
                        SELECT INTO _pgtrigger_ignore
                            CURRENT_SETTING('pgtrigger.ignore');
                        EXCEPTION WHEN OTHERS THEN
                    END;
                    IF _pgtrigger_ignore IS NOT NULL THEN
                        SELECT trigger_name = ANY(_pgtrigger_ignore)
                        INTO _result;
                        RETURN _result;
                    ELSE
                        RETURN FALSE;
                    END IF;
                END;
            $$ LANGUAGE plpgsql;

            CREATE OR REPLACE FUNCTION pgtrigger_update_or_delete_snapshot_update_137a5()
            RETURNS TRIGGER AS $$

                BEGIN
                    IF ("public"._pgtrigger_should_ignore(TG_NAME) IS TRUE) THEN
                        IF (TG_OP = 'DELETE') THEN
                            RETURN OLD;
                        ELSE
                            RETURN NEW;
                        END IF;
                    END IF;
                    INSERT INTO "search_claimhistoryevent" ("attachment_number", "claim_doc_id", "claim_document_type", "claim_id", "date_created", "date_filed", "date_modified", "date_upload", "description", "document_number", "file_size", "filepath_ia", "filepath_local", "ia_upload_failure_count", "id", "is_available", "is_free_on_pacer", "is_sealed", "ocr_status", "pacer_case_id", "pacer_dm_id", "pacer_doc_id", "page_count", "pgh_context_id", "pgh_created_at", "pgh_label", "pgh_obj_id", "plain_text", "sha1", "thumbnail", "thumbnail_status") VALUES (OLD."attachment_number", OLD."claim_doc_id", OLD."claim_document_type", OLD."claim_id", OLD."date_created", OLD."date_filed", OLD."date_modified", OLD."date_upload", OLD."description", OLD."document_number", OLD."file_size", OLD."filepath_ia", OLD."filepath_local", OLD."ia_upload_failure_count", OLD."id", OLD."is_available", OLD."is_free_on_pacer", OLD."is_sealed", OLD."ocr_status", OLD."pacer_case_id", OLD."pacer_dm_id", OLD."pacer_doc_id", OLD."page_count", _pgh_attach_context(), NOW(), 'update_or_delete_snapshot', OLD."id", OLD."plain_text", OLD."sha1", OLD."thumbnail", OLD."thumbnail_status"); RETURN NULL;
                END;
            $$ LANGUAGE plpgsql;

            DROP TRIGGER IF EXISTS pgtrigger_update_or_delete_snapshot_update_137a5 ON "search_claimhistory";
            CREATE  TRIGGER pgtrigger_update_or_delete_snapshot_update_137a5
                AFTER UPDATE ON "search_claimhistory"


                FOR EACH ROW WHEN (OLD."id" IS DISTINCT FROM (NEW."id") OR OLD."date_created" IS DISTINCT FROM (NEW."date_created") OR OLD."sha1" IS DISTINCT FROM (NEW."sha1") OR OLD."page_count" IS DISTINCT FROM (NEW."page_count") OR OLD."file_size" IS DISTINCT FROM (NEW."file_size") OR OLD."filepath_local" IS DISTINCT FROM (NEW."filepath_local") OR OLD."filepath_ia" IS DISTINCT FROM (NEW."filepath_ia") OR OLD."ia_upload_failure_count" IS DISTINCT FROM (NEW."ia_upload_failure_count") OR OLD."thumbnail" IS DISTINCT FROM (NEW."thumbnail") OR OLD."thumbnail_status" IS DISTINCT FROM (NEW."thumbnail_status") OR OLD."plain_text" IS DISTINCT FROM (NEW."plain_text") OR OLD."ocr_status" IS DISTINCT FROM (NEW."ocr_status") OR OLD."date_upload" IS DISTINCT FROM (NEW."date_upload") OR OLD."document_number" IS DISTINCT FROM (NEW."document_number") OR OLD."attachment_number" IS DISTINCT FROM (NEW."attachment_number") OR OLD."pacer_doc_id" IS DISTINCT FROM (NEW."pacer_doc_id") OR OLD."is_available" IS DISTINCT FROM (NEW."is_available") OR OLD."is_free_on_pacer" IS DISTINCT FROM (NEW."is_free_on_pacer") OR OLD."is_sealed" IS DISTINCT FROM (NEW."is_sealed") OR OLD."claim_id" IS DISTINCT FROM (NEW."claim_id") OR OLD."date_filed" IS DISTINCT FROM (NEW."date_filed") OR OLD."claim_document_type" IS DISTINCT FROM (NEW."claim_document_type") OR OLD."description" IS DISTINCT FROM (NEW."description") OR OLD."claim_doc_id" IS DISTINCT FROM (NEW."claim_doc_id") OR OLD."pacer_dm_id" IS DISTINCT FROM (NEW."pacer_dm_id") OR OLD."pacer_case_id" IS DISTINCT FROM (NEW."pacer_case_id"))
                EXECUTE PROCEDURE pgtrigger_update_or_delete_snapshot_update_137a5();

            COMMENT ON TRIGGER pgtrigger_update_or_delete_snapshot_update_137a5 ON "search_claimhistory" IS 'c4f2a33aa09534f0db6c38a62b0c4e2d656d1db0';

--
-- Create trigger update_or_delete_snapshot_update on model court
--

            CREATE OR REPLACE FUNCTION "public"._pgtrigger_should_ignore(
                trigger_name NAME
            )
            RETURNS BOOLEAN AS $$
                DECLARE
                    _pgtrigger_ignore TEXT[];
                    _result BOOLEAN;
                BEGIN
                    BEGIN
                        SELECT INTO _pgtrigger_ignore
                            CURRENT_SETTING('pgtrigger.ignore');
                        EXCEPTION WHEN OTHERS THEN
                    END;
                    IF _pgtrigger_ignore IS NOT NULL THEN
                        SELECT trigger_name = ANY(_pgtrigger_ignore)
                        INTO _result;
                        RETURN _result;
                    ELSE
                        RETURN FALSE;
                    END IF;
                END;
            $$ LANGUAGE plpgsql;

            CREATE OR REPLACE FUNCTION pgtrigger_update_or_delete_snapshot_update_c94ab()
            RETURNS TRIGGER AS $$

                BEGIN
                    IF ("public"._pgtrigger_should_ignore(TG_NAME) IS TRUE) THEN
                        IF (TG_OP = 'DELETE') THEN
                            RETURN OLD;
                        ELSE
                            RETURN NEW;
                        END IF;
                    END IF;
                    INSERT INTO "search_courtevent" ("citation_string", "date_last_pacer_contact", "date_modified", "end_date", "fjc_court_id", "full_name", "has_opinion_scraper", "has_oral_argument_scraper", "id", "in_use", "jurisdiction", "notes", "pacer_court_id", "pacer_has_rss_feed", "pacer_rss_entry_types", "pgh_context_id", "pgh_created_at", "pgh_label", "pgh_obj_id", "position", "short_name", "start_date", "url") VALUES (OLD."citation_string", OLD."date_last_pacer_contact", OLD."date_modified", OLD."end_date", OLD."fjc_court_id", OLD."full_name", OLD."has_opinion_scraper", OLD."has_oral_argument_scraper", OLD."id", OLD."in_use", OLD."jurisdiction", OLD."notes", OLD."pacer_court_id", OLD."pacer_has_rss_feed", OLD."pacer_rss_entry_types", _pgh_attach_context(), NOW(), 'update_or_delete_snapshot', OLD."id", OLD."position", OLD."short_name", OLD."start_date", OLD."url"); RETURN NULL;
                END;
            $$ LANGUAGE plpgsql;

            DROP TRIGGER IF EXISTS pgtrigger_update_or_delete_snapshot_update_c94ab ON "search_court";
            CREATE  TRIGGER pgtrigger_update_or_delete_snapshot_update_c94ab
                AFTER UPDATE ON "search_court"


                FOR EACH ROW WHEN (OLD."id" IS DISTINCT FROM (NEW."id") OR OLD."pacer_court_id" IS DISTINCT FROM (NEW."pacer_court_id") OR OLD."pacer_has_rss_feed" IS DISTINCT FROM (NEW."pacer_has_rss_feed") OR OLD."pacer_rss_entry_types" IS DISTINCT FROM (NEW."pacer_rss_entry_types") OR OLD."date_last_pacer_contact" IS DISTINCT FROM (NEW."date_last_pacer_contact") OR OLD."fjc_court_id" IS DISTINCT FROM (NEW."fjc_court_id") OR OLD."in_use" IS DISTINCT FROM (NEW."in_use") OR OLD."has_opinion_scraper" IS DISTINCT FROM (NEW."has_opinion_scraper") OR OLD."has_oral_argument_scraper" IS DISTINCT FROM (NEW."has_oral_argument_scraper") OR OLD."position" IS DISTINCT FROM (NEW."position") OR OLD."citation_string" IS DISTINCT FROM (NEW."citation_string") OR OLD."short_name" IS DISTINCT FROM (NEW."short_name") OR OLD."full_name" IS DISTINCT FROM (NEW."full_name") OR OLD."url" IS DISTINCT FROM (NEW."url") OR OLD."start_date" IS DISTINCT FROM (NEW."start_date") OR OLD."end_date" IS DISTINCT FROM (NEW."end_date") OR OLD."jurisdiction" IS DISTINCT FROM (NEW."jurisdiction") OR OLD."notes" IS DISTINCT FROM (NEW."notes"))
                EXECUTE PROCEDURE pgtrigger_update_or_delete_snapshot_update_c94ab();

            COMMENT ON TRIGGER pgtrigger_update_or_delete_snapshot_update_c94ab ON "search_court" IS '3d7ee4371f809a112d0ca08ebac797bfe18e404d';

--
-- Create trigger update_or_delete_snapshot_update on model docket
--

            CREATE OR REPLACE FUNCTION "public"._pgtrigger_should_ignore(
                trigger_name NAME
            )
            RETURNS BOOLEAN AS $$
                DECLARE
                    _pgtrigger_ignore TEXT[];
                    _result BOOLEAN;
                BEGIN
                    BEGIN
                        SELECT INTO _pgtrigger_ignore
                            CURRENT_SETTING('pgtrigger.ignore');
                        EXCEPTION WHEN OTHERS THEN
                    END;
                    IF _pgtrigger_ignore IS NOT NULL THEN
                        SELECT trigger_name = ANY(_pgtrigger_ignore)
                        INTO _result;
                        RETURN _result;
                    ELSE
                        RETURN FALSE;
                    END IF;
                END;
            $$ LANGUAGE plpgsql;

            CREATE OR REPLACE FUNCTION pgtrigger_update_or_delete_snapshot_update_7e039()
            RETURNS TRIGGER AS $$

                BEGIN
                    IF ("public"._pgtrigger_should_ignore(TG_NAME) IS TRUE) THEN
                        IF (TG_OP = 'DELETE') THEN
                            RETURN OLD;
                        ELSE
                            RETURN NEW;
                        END IF;
                    END IF;
                    INSERT INTO "search_docketevent" ("appeal_from_id", "appeal_from_str", "appellate_case_type_information", "appellate_fee_status", "assigned_to_id", "assigned_to_str", "blocked", "case_name", "case_name_full", "case_name_short", "cause", "court_id", "date_argued", "date_blocked", "date_cert_denied", "date_cert_granted", "date_created", "date_filed", "date_last_filing", "date_last_index", "date_modified", "date_reargued", "date_reargument_denied", "date_terminated", "docket_number", "docket_number_core", "filepath_ia", "filepath_ia_json", "filepath_local", "ia_date_first_change", "ia_needs_upload", "ia_upload_failure_count", "id", "idb_data_id", "jurisdiction_type", "jury_demand", "mdl_status", "nature_of_suit", "originating_court_information_id", "pacer_case_id", "panel_str", "pgh_context_id", "pgh_created_at", "pgh_label", "pgh_obj_id", "referred_to_id", "referred_to_str", "slug", "source") VALUES (OLD."appeal_from_id", OLD."appeal_from_str", OLD."appellate_case_type_information", OLD."appellate_fee_status", OLD."assigned_to_id", OLD."assigned_to_str", OLD."blocked", OLD."case_name", OLD."case_name_full", OLD."case_name_short", OLD."cause", OLD."court_id", OLD."date_argued", OLD."date_blocked", OLD."date_cert_denied", OLD."date_cert_granted", OLD."date_created", OLD."date_filed", OLD."date_last_filing", OLD."date_last_index", OLD."date_modified", OLD."date_reargued", OLD."date_reargument_denied", OLD."date_terminated", OLD."docket_number", OLD."docket_number_core", OLD."filepath_ia", OLD."filepath_ia_json", OLD."filepath_local", OLD."ia_date_first_change", OLD."ia_needs_upload", OLD."ia_upload_failure_count", OLD."id", OLD."idb_data_id", OLD."jurisdiction_type", OLD."jury_demand", OLD."mdl_status", OLD."nature_of_suit", OLD."originating_court_information_id", OLD."pacer_case_id", OLD."panel_str", _pgh_attach_context(), NOW(), 'update_or_delete_snapshot', OLD."id", OLD."referred_to_id", OLD."referred_to_str", OLD."slug", OLD."source"); RETURN NULL;
                END;
            $$ LANGUAGE plpgsql;

            DROP TRIGGER IF EXISTS pgtrigger_update_or_delete_snapshot_update_7e039 ON "search_docket";
            CREATE  TRIGGER pgtrigger_update_or_delete_snapshot_update_7e039
                AFTER UPDATE ON "search_docket"


                FOR EACH ROW WHEN (OLD."id" IS DISTINCT FROM (NEW."id") OR OLD."date_created" IS DISTINCT FROM (NEW."date_created") OR OLD."source" IS DISTINCT FROM (NEW."source") OR OLD."court_id" IS DISTINCT FROM (NEW."court_id") OR OLD."appeal_from_id" IS DISTINCT FROM (NEW."appeal_from_id") OR OLD."appeal_from_str" IS DISTINCT FROM (NEW."appeal_from_str") OR OLD."originating_court_information_id" IS DISTINCT FROM (NEW."originating_court_information_id") OR OLD."idb_data_id" IS DISTINCT FROM (NEW."idb_data_id") OR OLD."assigned_to_id" IS DISTINCT FROM (NEW."assigned_to_id") OR OLD."assigned_to_str" IS DISTINCT FROM (NEW."assigned_to_str") OR OLD."referred_to_id" IS DISTINCT FROM (NEW."referred_to_id") OR OLD."referred_to_str" IS DISTINCT FROM (NEW."referred_to_str") OR OLD."panel_str" IS DISTINCT FROM (NEW."panel_str") OR OLD."date_last_index" IS DISTINCT FROM (NEW."date_last_index") OR OLD."date_cert_granted" IS DISTINCT FROM (NEW."date_cert_granted") OR OLD."date_cert_denied" IS DISTINCT FROM (NEW."date_cert_denied") OR OLD."date_argued" IS DISTINCT FROM (NEW."date_argued") OR OLD."date_reargued" IS DISTINCT FROM (NEW."date_reargued") OR OLD."date_reargument_denied" IS DISTINCT FROM (NEW."date_reargument_denied") OR OLD."date_filed" IS DISTINCT FROM (NEW."date_filed") OR OLD."date_terminated" IS DISTINCT FROM (NEW."date_terminated") OR OLD."date_last_filing" IS DISTINCT FROM (NEW."date_last_filing") OR OLD."case_name_short" IS DISTINCT FROM (NEW."case_name_short") OR OLD."case_name" IS DISTINCT FROM (NEW."case_name") OR OLD."case_name_full" IS DISTINCT FROM (NEW."case_name_full") OR OLD."slug" IS DISTINCT FROM (NEW."slug") OR OLD."docket_number" IS DISTINCT FROM (NEW."docket_number") OR OLD."docket_number_core" IS DISTINCT FROM (NEW."docket_number_core") OR OLD."pacer_case_id" IS DISTINCT FROM (NEW."pacer_case_id") OR OLD."cause" IS DISTINCT FROM (NEW."cause") OR OLD."nature_of_suit" IS DISTINCT FROM (NEW."nature_of_suit") OR OLD."jury_demand" IS DISTINCT FROM (NEW."jury_demand") OR OLD."jurisdiction_type" IS DISTINCT FROM (NEW."jurisdiction_type") OR OLD."appellate_fee_status" IS DISTINCT FROM (NEW."appellate_fee_status") OR OLD."appellate_case_type_information" IS DISTINCT FROM (NEW."appellate_case_type_information") OR OLD."mdl_status" IS DISTINCT FROM (NEW."mdl_status") OR OLD."filepath_local" IS DISTINCT FROM (NEW."filepath_local") OR OLD."filepath_ia" IS DISTINCT FROM (NEW."filepath_ia") OR OLD."filepath_ia_json" IS DISTINCT FROM (NEW."filepath_ia_json") OR OLD."ia_upload_failure_count" IS DISTINCT FROM (NEW."ia_upload_failure_count") OR OLD."ia_needs_upload" IS DISTINCT FROM (NEW."ia_needs_upload") OR OLD."ia_date_first_change" IS DISTINCT FROM (NEW."ia_date_first_change") OR OLD."date_blocked" IS DISTINCT FROM (NEW."date_blocked") OR OLD."blocked" IS DISTINCT FROM (NEW."blocked"))
                EXECUTE PROCEDURE pgtrigger_update_or_delete_snapshot_update_7e039();

            COMMENT ON TRIGGER pgtrigger_update_or_delete_snapshot_update_7e039 ON "search_docket" IS 'cab7d35a7309b21c85f837b8a6c4759febe46fd8';

--
-- Create trigger update_or_delete_snapshot_update on model docketentry
--

            CREATE OR REPLACE FUNCTION "public"._pgtrigger_should_ignore(
                trigger_name NAME
            )
            RETURNS BOOLEAN AS $$
                DECLARE
                    _pgtrigger_ignore TEXT[];
                    _result BOOLEAN;
                BEGIN
                    BEGIN
                        SELECT INTO _pgtrigger_ignore
                            CURRENT_SETTING('pgtrigger.ignore');
                        EXCEPTION WHEN OTHERS THEN
                    END;
                    IF _pgtrigger_ignore IS NOT NULL THEN
                        SELECT trigger_name = ANY(_pgtrigger_ignore)
                        INTO _result;
                        RETURN _result;
                    ELSE
                        RETURN FALSE;
                    END IF;
                END;
            $$ LANGUAGE plpgsql;

            CREATE OR REPLACE FUNCTION pgtrigger_update_or_delete_snapshot_update_46e1e()
            RETURNS TRIGGER AS $$

                BEGIN
                    IF ("public"._pgtrigger_should_ignore(TG_NAME) IS TRUE) THEN
                        IF (TG_OP = 'DELETE') THEN
                            RETURN OLD;
                        ELSE
                            RETURN NEW;
                        END IF;
                    END IF;
                    INSERT INTO "search_docketentryevent" ("date_created", "date_filed", "date_modified", "description", "docket_id", "entry_number", "id", "pacer_sequence_number", "pgh_context_id", "pgh_created_at", "pgh_label", "pgh_obj_id", "recap_sequence_number", "time_filed") VALUES (OLD."date_created", OLD."date_filed", OLD."date_modified", OLD."description", OLD."docket_id", OLD."entry_number", OLD."id", OLD."pacer_sequence_number", _pgh_attach_context(), NOW(), 'update_or_delete_snapshot', OLD."id", OLD."recap_sequence_number", OLD."time_filed"); RETURN NULL;
                END;
            $$ LANGUAGE plpgsql;

            DROP TRIGGER IF EXISTS pgtrigger_update_or_delete_snapshot_update_46e1e ON "search_docketentry";
            CREATE  TRIGGER pgtrigger_update_or_delete_snapshot_update_46e1e
                AFTER UPDATE ON "search_docketentry"


                FOR EACH ROW WHEN (OLD."id" IS DISTINCT FROM (NEW."id") OR OLD."date_created" IS DISTINCT FROM (NEW."date_created") OR OLD."docket_id" IS DISTINCT FROM (NEW."docket_id") OR OLD."date_filed" IS DISTINCT FROM (NEW."date_filed") OR OLD."time_filed" IS DISTINCT FROM (NEW."time_filed") OR OLD."entry_number" IS DISTINCT FROM (NEW."entry_number") OR OLD."recap_sequence_number" IS DISTINCT FROM (NEW."recap_sequence_number") OR OLD."pacer_sequence_number" IS DISTINCT FROM (NEW."pacer_sequence_number") OR OLD."description" IS DISTINCT FROM (NEW."description"))
                EXECUTE PROCEDURE pgtrigger_update_or_delete_snapshot_update_46e1e();

            COMMENT ON TRIGGER pgtrigger_update_or_delete_snapshot_update_46e1e ON "search_docketentry" IS '2330fe784864bcc2d76ebe1d4a07e7819fa8de38';

--
-- Create trigger update_or_delete_snapshot_update on model opinion
--

            CREATE OR REPLACE FUNCTION "public"._pgtrigger_should_ignore(
                trigger_name NAME
            )
            RETURNS BOOLEAN AS $$
                DECLARE
                    _pgtrigger_ignore TEXT[];
                    _result BOOLEAN;
                BEGIN
                    BEGIN
                        SELECT INTO _pgtrigger_ignore
                            CURRENT_SETTING('pgtrigger.ignore');
                        EXCEPTION WHEN OTHERS THEN
                    END;
                    IF _pgtrigger_ignore IS NOT NULL THEN
                        SELECT trigger_name = ANY(_pgtrigger_ignore)
                        INTO _result;
                        RETURN _result;
                    ELSE
                        RETURN FALSE;
                    END IF;
                END;
            $$ LANGUAGE plpgsql;

            CREATE OR REPLACE FUNCTION pgtrigger_update_or_delete_snapshot_update_67ecd()
            RETURNS TRIGGER AS $$

                BEGIN
                    IF ("public"._pgtrigger_should_ignore(TG_NAME) IS TRUE) THEN
                        IF (TG_OP = 'DELETE') THEN
                            RETURN OLD;
                        ELSE
                            RETURN NEW;
                        END IF;
                    END IF;
                    INSERT INTO "search_opinionevent" ("author_id", "author_str", "cluster_id", "date_created", "date_modified", "download_url", "extracted_by_ocr", "html", "html_anon_2020", "html_columbia", "html_lawbox", "html_with_citations", "id", "joined_by_str", "local_path", "page_count", "per_curiam", "pgh_context_id", "pgh_created_at", "pgh_label", "pgh_obj_id", "plain_text", "sha1", "type", "xml_harvard") VALUES (OLD."author_id", OLD."author_str", OLD."cluster_id", OLD."date_created", OLD."date_modified", OLD."download_url", OLD."extracted_by_ocr", OLD."html", OLD."html_anon_2020", OLD."html_columbia", OLD."html_lawbox", OLD."html_with_citations", OLD."id", OLD."joined_by_str", OLD."local_path", OLD."page_count", OLD."per_curiam", _pgh_attach_context(), NOW(), 'update_or_delete_snapshot', OLD."id", OLD."plain_text", OLD."sha1", OLD."type", OLD."xml_harvard"); RETURN NULL;
                END;
            $$ LANGUAGE plpgsql;

            DROP TRIGGER IF EXISTS pgtrigger_update_or_delete_snapshot_update_67ecd ON "search_opinion";
            CREATE  TRIGGER pgtrigger_update_or_delete_snapshot_update_67ecd
                AFTER UPDATE ON "search_opinion"


                FOR EACH ROW WHEN (OLD."id" IS DISTINCT FROM (NEW."id") OR OLD."date_created" IS DISTINCT FROM (NEW."date_created") OR OLD."cluster_id" IS DISTINCT FROM (NEW."cluster_id") OR OLD."author_id" IS DISTINCT FROM (NEW."author_id") OR OLD."author_str" IS DISTINCT FROM (NEW."author_str") OR OLD."per_curiam" IS DISTINCT FROM (NEW."per_curiam") OR OLD."joined_by_str" IS DISTINCT FROM (NEW."joined_by_str") OR OLD."type" IS DISTINCT FROM (NEW."type") OR OLD."sha1" IS DISTINCT FROM (NEW."sha1") OR OLD."page_count" IS DISTINCT FROM (NEW."page_count") OR OLD."download_url" IS DISTINCT FROM (NEW."download_url") OR OLD."local_path" IS DISTINCT FROM (NEW."local_path") OR OLD."plain_text" IS DISTINCT FROM (NEW."plain_text") OR OLD."html" IS DISTINCT FROM (NEW."html") OR OLD."html_lawbox" IS DISTINCT FROM (NEW."html_lawbox") OR OLD."html_columbia" IS DISTINCT FROM (NEW."html_columbia") OR OLD."html_anon_2020" IS DISTINCT FROM (NEW."html_anon_2020") OR OLD."xml_harvard" IS DISTINCT FROM (NEW."xml_harvard") OR OLD."html_with_citations" IS DISTINCT FROM (NEW."html_with_citations") OR OLD."extracted_by_ocr" IS DISTINCT FROM (NEW."extracted_by_ocr"))
                EXECUTE PROCEDURE pgtrigger_update_or_delete_snapshot_update_67ecd();

            COMMENT ON TRIGGER pgtrigger_update_or_delete_snapshot_update_67ecd ON "search_opinion" IS '4a3d82790ac0cbd840d6a7f6c136d4cc65419e5e';

--
-- Create trigger update_or_delete_snapshot_update on model opinioncluster
--

            CREATE OR REPLACE FUNCTION "public"._pgtrigger_should_ignore(
                trigger_name NAME
            )
            RETURNS BOOLEAN AS $$
                DECLARE
                    _pgtrigger_ignore TEXT[];
                    _result BOOLEAN;
                BEGIN
                    BEGIN
                        SELECT INTO _pgtrigger_ignore
                            CURRENT_SETTING('pgtrigger.ignore');
                        EXCEPTION WHEN OTHERS THEN
                    END;
                    IF _pgtrigger_ignore IS NOT NULL THEN
                        SELECT trigger_name = ANY(_pgtrigger_ignore)
                        INTO _result;
                        RETURN _result;
                    ELSE
                        RETURN FALSE;
                    END IF;
                END;
            $$ LANGUAGE plpgsql;

            CREATE OR REPLACE FUNCTION pgtrigger_update_or_delete_snapshot_update_6a181()
            RETURNS TRIGGER AS $$

                BEGIN
                    IF ("public"._pgtrigger_should_ignore(TG_NAME) IS TRUE) THEN
                        IF (TG_OP = 'DELETE') THEN
                            RETURN OLD;
                        ELSE
                            RETURN NEW;
                        END IF;
                    END IF;
                    INSERT INTO "search_opinionclusterevent" ("attorneys", "blocked", "case_name", "case_name_full", "case_name_short", "citation_count", "correction", "cross_reference", "date_blocked", "date_created", "date_filed", "date_filed_is_approximate", "date_modified", "disposition", "docket_id", "filepath_json_harvard", "headnotes", "history", "id", "judges", "nature_of_suit", "other_dates", "pgh_context_id", "pgh_created_at", "pgh_label", "pgh_obj_id", "posture", "precedential_status", "procedural_history", "scdb_decision_direction", "scdb_id", "scdb_votes_majority", "scdb_votes_minority", "slug", "source", "summary", "syllabus") VALUES (OLD."attorneys", OLD."blocked", OLD."case_name", OLD."case_name_full", OLD."case_name_short", OLD."citation_count", OLD."correction", OLD."cross_reference", OLD."date_blocked", OLD."date_created", OLD."date_filed", OLD."date_filed_is_approximate", OLD."date_modified", OLD."disposition", OLD."docket_id", OLD."filepath_json_harvard", OLD."headnotes", OLD."history", OLD."id", OLD."judges", OLD."nature_of_suit", OLD."other_dates", _pgh_attach_context(), NOW(), 'update_or_delete_snapshot', OLD."id", OLD."posture", OLD."precedential_status", OLD."procedural_history", OLD."scdb_decision_direction", OLD."scdb_id", OLD."scdb_votes_majority", OLD."scdb_votes_minority", OLD."slug", OLD."source", OLD."summary", OLD."syllabus"); RETURN NULL;
                END;
            $$ LANGUAGE plpgsql;

            DROP TRIGGER IF EXISTS pgtrigger_update_or_delete_snapshot_update_6a181 ON "search_opinioncluster";
            CREATE  TRIGGER pgtrigger_update_or_delete_snapshot_update_6a181
                AFTER UPDATE ON "search_opinioncluster"


                FOR EACH ROW WHEN (OLD."id" IS DISTINCT FROM (NEW."id") OR OLD."date_created" IS DISTINCT FROM (NEW."date_created") OR OLD."docket_id" IS DISTINCT FROM (NEW."docket_id") OR OLD."judges" IS DISTINCT FROM (NEW."judges") OR OLD."date_filed" IS DISTINCT FROM (NEW."date_filed") OR OLD."date_filed_is_approximate" IS DISTINCT FROM (NEW."date_filed_is_approximate") OR OLD."slug" IS DISTINCT FROM (NEW."slug") OR OLD."case_name_short" IS DISTINCT FROM (NEW."case_name_short") OR OLD."case_name" IS DISTINCT FROM (NEW."case_name") OR OLD."case_name_full" IS DISTINCT FROM (NEW."case_name_full") OR OLD."scdb_id" IS DISTINCT FROM (NEW."scdb_id") OR OLD."scdb_decision_direction" IS DISTINCT FROM (NEW."scdb_decision_direction") OR OLD."scdb_votes_majority" IS DISTINCT FROM (NEW."scdb_votes_majority") OR OLD."scdb_votes_minority" IS DISTINCT FROM (NEW."scdb_votes_minority") OR OLD."source" IS DISTINCT FROM (NEW."source") OR OLD."procedural_history" IS DISTINCT FROM (NEW."procedural_history") OR OLD."attorneys" IS DISTINCT FROM (NEW."attorneys") OR OLD."nature_of_suit" IS DISTINCT FROM (NEW."nature_of_suit") OR OLD."posture" IS DISTINCT FROM (NEW."posture") OR OLD."syllabus" IS DISTINCT FROM (NEW."syllabus") OR OLD."headnotes" IS DISTINCT FROM (NEW."headnotes") OR OLD."summary" IS DISTINCT FROM (NEW."summary") OR OLD."disposition" IS DISTINCT FROM (NEW."disposition") OR OLD."history" IS DISTINCT FROM (NEW."history") OR OLD."other_dates" IS DISTINCT FROM (NEW."other_dates") OR OLD."cross_reference" IS DISTINCT FROM (NEW."cross_reference") OR OLD."correction" IS DISTINCT FROM (NEW."correction") OR OLD."citation_count" IS DISTINCT FROM (NEW."citation_count") OR OLD."precedential_status" IS DISTINCT FROM (NEW."precedential_status") OR OLD."date_blocked" IS DISTINCT FROM (NEW."date_blocked") OR OLD."blocked" IS DISTINCT FROM (NEW."blocked") OR OLD."filepath_json_harvard" IS DISTINCT FROM (NEW."filepath_json_harvard"))
                EXECUTE PROCEDURE pgtrigger_update_or_delete_snapshot_update_6a181();

            COMMENT ON TRIGGER pgtrigger_update_or_delete_snapshot_update_6a181 ON "search_opinioncluster" IS '907cc0f72768dba7763ab81e6e1c65f362301716';

--
-- Create trigger update_or_delete_snapshot_update on model originatingcourtinformation
--

            CREATE OR REPLACE FUNCTION "public"._pgtrigger_should_ignore(
                trigger_name NAME
            )
            RETURNS BOOLEAN AS $$
                DECLARE
                    _pgtrigger_ignore TEXT[];
                    _result BOOLEAN;
                BEGIN
                    BEGIN
                        SELECT INTO _pgtrigger_ignore
                            CURRENT_SETTING('pgtrigger.ignore');
                        EXCEPTION WHEN OTHERS THEN
                    END;
                    IF _pgtrigger_ignore IS NOT NULL THEN
                        SELECT trigger_name = ANY(_pgtrigger_ignore)
                        INTO _result;
                        RETURN _result;
                    ELSE
                        RETURN FALSE;
                    END IF;
                END;
            $$ LANGUAGE plpgsql;

            CREATE OR REPLACE FUNCTION pgtrigger_update_or_delete_snapshot_update_49538()
            RETURNS TRIGGER AS $$

                BEGIN
                    IF ("public"._pgtrigger_should_ignore(TG_NAME) IS TRUE) THEN
                        IF (TG_OP = 'DELETE') THEN
                            RETURN OLD;
                        ELSE
                            RETURN NEW;
                        END IF;
                    END IF;
                    INSERT INTO "search_originatingcourtinformationevent" ("assigned_to_id", "assigned_to_str", "court_reporter", "date_created", "date_disposed", "date_filed", "date_filed_noa", "date_judgment", "date_judgment_eod", "date_modified", "date_received_coa", "docket_number", "id", "ordering_judge_id", "ordering_judge_str", "pgh_context_id", "pgh_created_at", "pgh_label", "pgh_obj_id") VALUES (OLD."assigned_to_id", OLD."assigned_to_str", OLD."court_reporter", OLD."date_created", OLD."date_disposed", OLD."date_filed", OLD."date_filed_noa", OLD."date_judgment", OLD."date_judgment_eod", OLD."date_modified", OLD."date_received_coa", OLD."docket_number", OLD."id", OLD."ordering_judge_id", OLD."ordering_judge_str", _pgh_attach_context(), NOW(), 'update_or_delete_snapshot', OLD."id"); RETURN NULL;
                END;
            $$ LANGUAGE plpgsql;

            DROP TRIGGER IF EXISTS pgtrigger_update_or_delete_snapshot_update_49538 ON "search_originatingcourtinformation";
            CREATE  TRIGGER pgtrigger_update_or_delete_snapshot_update_49538
                AFTER UPDATE ON "search_originatingcourtinformation"


                FOR EACH ROW WHEN (OLD."id" IS DISTINCT FROM (NEW."id") OR OLD."date_created" IS DISTINCT FROM (NEW."date_created") OR OLD."docket_number" IS DISTINCT FROM (NEW."docket_number") OR OLD."assigned_to_id" IS DISTINCT FROM (NEW."assigned_to_id") OR OLD."assigned_to_str" IS DISTINCT FROM (NEW."assigned_to_str") OR OLD."ordering_judge_id" IS DISTINCT FROM (NEW."ordering_judge_id") OR OLD."ordering_judge_str" IS DISTINCT FROM (NEW."ordering_judge_str") OR OLD."court_reporter" IS DISTINCT FROM (NEW."court_reporter") OR OLD."date_disposed" IS DISTINCT FROM (NEW."date_disposed") OR OLD."date_filed" IS DISTINCT FROM (NEW."date_filed") OR OLD."date_judgment" IS DISTINCT FROM (NEW."date_judgment") OR OLD."date_judgment_eod" IS DISTINCT FROM (NEW."date_judgment_eod") OR OLD."date_filed_noa" IS DISTINCT FROM (NEW."date_filed_noa") OR OLD."date_received_coa" IS DISTINCT FROM (NEW."date_received_coa"))
                EXECUTE PROCEDURE pgtrigger_update_or_delete_snapshot_update_49538();

            COMMENT ON TRIGGER pgtrigger_update_or_delete_snapshot_update_49538 ON "search_originatingcourtinformation" IS '5d249a18e8be51afa8c54132770efcdde2b47a61';

--
-- Create trigger update_or_delete_snapshot_update on model recapdocument
--

            CREATE OR REPLACE FUNCTION "public"._pgtrigger_should_ignore(
                trigger_name NAME
            )
            RETURNS BOOLEAN AS $$
                DECLARE
                    _pgtrigger_ignore TEXT[];
                    _result BOOLEAN;
                BEGIN
                    BEGIN
                        SELECT INTO _pgtrigger_ignore
                            CURRENT_SETTING('pgtrigger.ignore');
                        EXCEPTION WHEN OTHERS THEN
                    END;
                    IF _pgtrigger_ignore IS NOT NULL THEN
                        SELECT trigger_name = ANY(_pgtrigger_ignore)
                        INTO _result;
                        RETURN _result;
                    ELSE
                        RETURN FALSE;
                    END IF;
                END;
            $$ LANGUAGE plpgsql;

            CREATE OR REPLACE FUNCTION pgtrigger_update_or_delete_snapshot_update_8a108()
            RETURNS TRIGGER AS $$

                BEGIN
                    IF ("public"._pgtrigger_should_ignore(TG_NAME) IS TRUE) THEN
                        IF (TG_OP = 'DELETE') THEN
                            RETURN OLD;
                        ELSE
                            RETURN NEW;
                        END IF;
                    END IF;
                    INSERT INTO "search_recapdocumentevent" ("attachment_number", "date_created", "date_modified", "date_upload", "description", "docket_entry_id", "document_number", "document_type", "file_size", "filepath_ia", "filepath_local", "ia_upload_failure_count", "id", "is_available", "is_free_on_pacer", "is_sealed", "ocr_status", "pacer_doc_id", "page_count", "pgh_context_id", "pgh_created_at", "pgh_label", "pgh_obj_id", "plain_text", "sha1", "thumbnail", "thumbnail_status") VALUES (OLD."attachment_number", OLD."date_created", OLD."date_modified", OLD."date_upload", OLD."description", OLD."docket_entry_id", OLD."document_number", OLD."document_type", OLD."file_size", OLD."filepath_ia", OLD."filepath_local", OLD."ia_upload_failure_count", OLD."id", OLD."is_available", OLD."is_free_on_pacer", OLD."is_sealed", OLD."ocr_status", OLD."pacer_doc_id", OLD."page_count", _pgh_attach_context(), NOW(), 'update_or_delete_snapshot', OLD."id", OLD."plain_text", OLD."sha1", OLD."thumbnail", OLD."thumbnail_status"); RETURN NULL;
                END;
            $$ LANGUAGE plpgsql;

            DROP TRIGGER IF EXISTS pgtrigger_update_or_delete_snapshot_update_8a108 ON "search_recapdocument";
            CREATE  TRIGGER pgtrigger_update_or_delete_snapshot_update_8a108
                AFTER UPDATE ON "search_recapdocument"


                FOR EACH ROW WHEN (OLD."id" IS DISTINCT FROM (NEW."id") OR OLD."date_created" IS DISTINCT FROM (NEW."date_created") OR OLD."sha1" IS DISTINCT FROM (NEW."sha1") OR OLD."page_count" IS DISTINCT FROM (NEW."page_count") OR OLD."file_size" IS DISTINCT FROM (NEW."file_size") OR OLD."filepath_local" IS DISTINCT FROM (NEW."filepath_local") OR OLD."filepath_ia" IS DISTINCT FROM (NEW."filepath_ia") OR OLD."ia_upload_failure_count" IS DISTINCT FROM (NEW."ia_upload_failure_count") OR OLD."thumbnail" IS DISTINCT FROM (NEW."thumbnail") OR OLD."thumbnail_status" IS DISTINCT FROM (NEW."thumbnail_status") OR OLD."plain_text" IS DISTINCT FROM (NEW."plain_text") OR OLD."ocr_status" IS DISTINCT FROM (NEW."ocr_status") OR OLD."date_upload" IS DISTINCT FROM (NEW."date_upload") OR OLD."document_number" IS DISTINCT FROM (NEW."document_number") OR OLD."attachment_number" IS DISTINCT FROM (NEW."attachment_number") OR OLD."pacer_doc_id" IS DISTINCT FROM (NEW."pacer_doc_id") OR OLD."is_available" IS DISTINCT FROM (NEW."is_available") OR OLD."is_free_on_pacer" IS DISTINCT FROM (NEW."is_free_on_pacer") OR OLD."is_sealed" IS DISTINCT FROM (NEW."is_sealed") OR OLD."docket_entry_id" IS DISTINCT FROM (NEW."docket_entry_id") OR OLD."document_type" IS DISTINCT FROM (NEW."document_type") OR OLD."description" IS DISTINCT FROM (NEW."description"))
                EXECUTE PROCEDURE pgtrigger_update_or_delete_snapshot_update_8a108();

            COMMENT ON TRIGGER pgtrigger_update_or_delete_snapshot_update_8a108 ON "search_recapdocument" IS 'a3e0c759d8c03f380dd3eddfcff551091fcee1d1';

--
-- Create trigger update_or_delete_snapshot_update on model tag
--

            CREATE OR REPLACE FUNCTION "public"._pgtrigger_should_ignore(
                trigger_name NAME
            )
            RETURNS BOOLEAN AS $$
                DECLARE
                    _pgtrigger_ignore TEXT[];
                    _result BOOLEAN;
                BEGIN
                    BEGIN
                        SELECT INTO _pgtrigger_ignore
                            CURRENT_SETTING('pgtrigger.ignore');
                        EXCEPTION WHEN OTHERS THEN
                    END;
                    IF _pgtrigger_ignore IS NOT NULL THEN
                        SELECT trigger_name = ANY(_pgtrigger_ignore)
                        INTO _result;
                        RETURN _result;
                    ELSE
                        RETURN FALSE;
                    END IF;
                END;
            $$ LANGUAGE plpgsql;

            CREATE OR REPLACE FUNCTION pgtrigger_update_or_delete_snapshot_update_c9dd9()
            RETURNS TRIGGER AS $$

                BEGIN
                    IF ("public"._pgtrigger_should_ignore(TG_NAME) IS TRUE) THEN
                        IF (TG_OP = 'DELETE') THEN
                            RETURN OLD;
                        ELSE
                            RETURN NEW;
                        END IF;
                    END IF;
                    INSERT INTO "search_tagevent" ("date_created", "date_modified", "id", "name", "pgh_context_id", "pgh_created_at", "pgh_label", "pgh_obj_id") VALUES (OLD."date_created", OLD."date_modified", OLD."id", OLD."name", _pgh_attach_context(), NOW(), 'update_or_delete_snapshot', OLD."id"); RETURN NULL;
                END;
            $$ LANGUAGE plpgsql;

            DROP TRIGGER IF EXISTS pgtrigger_update_or_delete_snapshot_update_c9dd9 ON "search_tag";
            CREATE  TRIGGER pgtrigger_update_or_delete_snapshot_update_c9dd9
                AFTER UPDATE ON "search_tag"


                FOR EACH ROW WHEN (OLD."id" IS DISTINCT FROM (NEW."id") OR OLD."date_created" IS DISTINCT FROM (NEW."date_created") OR OLD."name" IS DISTINCT FROM (NEW."name"))
                EXECUTE PROCEDURE pgtrigger_update_or_delete_snapshot_update_c9dd9();

            COMMENT ON TRIGGER pgtrigger_update_or_delete_snapshot_update_c9dd9 ON "search_tag" IS '4071657dcfe71811e9e7a5c24dd77c22f81d7377';

COMMIT;
