from typing import Optional

from juriscraper import AbstractSite
from juriscraper.AbstractSite import logger
from juriscraper.lib.importer import site_yielder

from cl.scrapers.management.commands import cl_scrape_opinions


class Command(cl_scrape_opinions.Command):
    def parse_and_scrape_site(
        self,
        mod: AbstractSite,
        full_crawl: bool,
        backscrape_start: Optional[str] = None,
        backscrape_end: Optional[str] = None,
    ) -> None:
        """Parse the site and scrape it using the backscraper

        :param mod: The jusriscraper Site object to scrape
        :param full_crawl: Whether or not to do a full crawl (Ignored value)
        :param backscrape_start: string which may be a date, year, index, etc.
                which is parsed and used by a scraper as start value for the
                range to be backscraped
        :param backscrape_end: end value for backscraper range
        :return: None
        """
        court_str = mod.__name__.split(".")[-1].split("_")[0]
        logger.info(f'Using court_str: "{court_str}"')
        for site in site_yielder(
            mod.Site(
                backscrape_start=backscrape_start,
                backscrape_end=backscrape_end,
            ).back_scrape_iterable,
            mod,
        ):
            site.parse()
            self.scrape_court(site, full_crawl=True)

    def save_everything(self, items, index=False, backscrape=True):
        super().save_everything(items, index, backscrape)
