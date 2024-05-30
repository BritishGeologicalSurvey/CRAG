"""
Quick script for accessing and deleting projects from the mergin API client.
Takes a single argument in the command line which is the search term that
will be used to find matching projects by name.
"""
import argparse
import os
from pathlib import Path
from typing import Any

import mergin

from plugin.utils import ipdb_breakpoint  # noqa


class MerginSigma:
    """
    Helper class including preset variables which are used in the mergin client.
    """
    def __init__(self):
        self.local_dir = Path("mergin_projects/")
        self.local_dir.mkdir(exist_ok=True)
        self.client = mergin.MerginClient(login=os.environ["MERGIN_USERNAME"], password=os.environ["MERGIN_PASSWORD"])
        self.namespace = "SIGMALite"

    def project_path(self, project_name: str) -> str:
        """
        Generate the full project path for the given project name including the namespace.
        """
        return f"{self.namespace}/{project_name}"

    def download_project(self, project_name: str) -> None:
        """
        Download the given project from the mergin API.
        """
        download_dir = self.local_dir / project_name
        self.client.download_project(self.project_path(project_name), str(download_dir))

    def get_projects(self) -> list[dict[str, Any]]:
        return self.client.projects_list(namespace=self.namespace)

    def delete_projects(self, projects: str | list[str]) -> None:
        """
        Delete the given project(s).
        """
        # If the given projects is just a single project, put it in a list for the loop
        if isinstance(projects, str):
            projects = [projects]

        if input(f"\nConfirm delete {len(projects)} projects from {self.namespace} (Y/N): ").lower() in {"y", "yes"}:
            print("Deleting...")
            for project in projects:
                print(f"\t{project}")
                self.client.delete_project(self.project_path(project))


def search_and_delete_projects(search: str) -> None:
    """
    Search for projects which contain the given search term and ask user for deletion confirmation.
    """
    mergin_sigma = MerginSigma()

    # mergin_sigma.download_project("conflict-bug-min-20240503-qgis-to-qgis")

    # Get all projects and hash them by name for easy look up
    projects = mergin_sigma.get_projects()
    projects_by_name = {project["name"]: project for project in projects}

    match_projects = get_matching_projects(projects_by_name, search)

    mergin_sigma.delete_projects(match_projects)


def get_matching_projects(projects_by_name: dict[str, dict[str, Any]], search: str) -> list[str]:
    """
    Get just the projects from the given dictionary which contain the given search
    term in their name. Ignores projects which are public.
    """
    # Get just the matching projects
    match_projects = [
        project["name"]
        for project in projects_by_name.values()
        # Get projects with search term in name that are not public
        # Public projects may be in bug reports
        if search in project["name"].lower() and not project["access"]["public"]
    ]

    # Output results
    print(f"Found {len(match_projects)} projects for search '{search}':")
    for project in match_projects:
        fields = "\t".join([
            project,
            projects_by_name[project]["updated"],
            ",".join(projects_by_name[project]["access"]["ownersnames"]),
        ])
        print(f"\t{fields}")

    return match_projects


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("search")
    search_and_delete_projects(search=parser.parse_args().search)
