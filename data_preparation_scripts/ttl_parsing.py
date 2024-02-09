import csv
import json
import logging
from pathlib import Path
from typing import (
    Any,
    Optional,
    Union,
)

import networkx as nx
from rdflib import Graph
from rdflib.term import URIRef

from data_preparation_scripts.sld_xml_parsing import main as parse_sld

GraphDict = dict[str, dict[str, list[Any]]]
ParentSets = dict[str, dict[str, Union[str, set[str]]]]

logging.basicConfig(
    level=logging.INFO,
    format="%(levelname)s: %(asctime)s %(name)s: %(message)s",
    datefmt="{%Y-%m-%d %H:%M:%S}",
)
logger = logging.getLogger("".join([word.capitalize() for word in Path(__file__).stem.split("_")]))


def main(
    uri: str = "https://raw.githubusercontent.com/CGI-IUGS/cgi-vocabs/9dfe161affbe91de4c25622a9c2cfab5aa65c642/vocabularies/geosciml/simplelithology.ttl",  # noqa
) -> tuple[GraphDict, ParentSets]:
    """
    Parse the given TTL file for simplelithology, and get the parents for each subject.
    The set of parents is recursive up to the root, compound material.
    Returns the dictionary representation of the RDF graph for only the skos namespace data,
    and returns a dictionary of subject prefLabel predicates as keys,
    and the set of parent prefLabel predicates as values.
    """
    logger.info("Parsing TTL file: %s", uri)
    # Create new graph
    graph = Graph()
    # Parse the ttl file from the GitHub URI
    graph.parse(uri, format="ttl")

    # Get the skos namespace definition from the ttl file namespaces
    # namespaces are tuples with 2 items, [namespace identifer, namespace URI]
    skos = [namespace[1] for namespace in graph.namespaces() if namespace[0] == "skos"][0]

    # Define the subject prefix we are looking for
    lithology_prefix = "http://resource.geosciml.org/classifier/cgi/lithology/"

    graph_dict = rdflib_graph_to_dict(graph, namespace=skos, subject_prefix=lithology_prefix)

    parent_sets = get_parent_sets(graph_dict)

    lithology_hexes = parse_sld()

    generate_csv_file(
        Path("simple_lithology_parents.csv"),
        parent_sets,
        lithology_hexes,
    )
    # create_graph(Path("ttl-graph.png"), graph_dict)

    return graph_dict, parent_sets


def rdflib_graph_to_dict(
    graph: Graph,
    namespace: URIRef,
    subject_prefix: str,
) -> GraphDict:
    """
    Convert the RDFLib graph data into a Python dictionary, only taking the data from the given namespace.
    The dictionary structure follows:
    {subject (full URI): {predicate: list[object_]}}
    There can be multiple objects per predicate so the predicate corresponds to a list of objects.
    """
    graph_dict: GraphDict = {}
    # The subject, predicate and object makes up each triple
    # Easier explanation is subject, property, value
    # Can be thought of like database structure: row, column, value
    for subject, predicate, object_ in graph:

        # Convert the subject instance to a Python string
        subject = subject.toPython()

        # If the subject has the correct prefix AND the predicate is in the given namespace
        if subject.startswith(subject_prefix) and predicate.startswith(namespace):

            # Get the attribute name by removing the namespace prefix
            attribute = predicate.removeprefix(namespace)

            # Ensure the dictionary structure is present
            if subject not in graph_dict:
                graph_dict[subject] = {}
            if attribute not in graph_dict[subject]:
                graph_dict[subject][attribute] = []

            # Add the new object to the dictionary
            graph_dict[subject][attribute].append(object_)

    logger.info("Found %s lithologies in graph", len(graph_dict))
    return graph_dict


def get_parent_sets(graph_dict: GraphDict) -> ParentSets:
    """
    Get a the set of parents for each subject in the given graph dictionary.
    The return value is a dictionary where the keys are string labels and the values are
    the set of parent labels as strings.
    """
    parent_sets: ParentSets = {}
    for subject, predicates in graph_dict.items():
        subject_label = get_english_label(predicates["prefLabel"])

        parents = recursive_get_parents(graph_dict, parent_sets, subject=subject, subject_label=subject_label)

        logger.debug("Found %s parents for subject: %s", len(parents), subject_label)
        parent_sets[subject_label] = {
            "simple_lithology_uri": subject,
            "parents": parents,
        }

    logger.info("Found all recursive parents")
    return parent_sets


def recursive_get_parents(
    graph_dict: GraphDict,
    parent_sets: ParentSets,
    subject: str,
    subject_label: str,
    parents: Optional[set[str]] = None,
) -> set[str]:
    """
    Recursively get the parents of the given subject.
    Returns a set of all pefLabel predicates for the discovered parents.
    """
    # Initalise empty set to store all parents for given subject at the start of recursion
    if parents is None:
        parents = set()

    # Else, add the current subject to the parent set as it is not the first subject
    else:
        parents.add(subject_label)

    # If we have already found the set of parents for this parent
    # just get it from the current results
    if subject_label in parent_sets:
        # Add the parents for the current subject to the overall set of parents
        parents = parents.union(parent_sets[subject_label]["parents"])
        logger.debug("Saved recusion of depth %s for: %s", len(parent_sets[subject_label]["parents"]), subject_label)

    # Else if the given subject has parents
    elif "broader" in graph_dict[subject]:
        for parent_subject in graph_dict[subject]["broader"]:

            # Convert the parent_subject to a Python string for dictionary indexing
            parent_subject = parent_subject.toPython()
            parent_label = get_english_label(graph_dict[parent_subject]["prefLabel"])

            # Recursively discover the parents of this parent
            parents = recursive_get_parents(
                graph_dict,
                parent_sets,
                subject=parent_subject,
                subject_label=parent_label,
                parents=parents,
            )

    return parents


def generate_csv_file(
    filepath: Path,
    parent_sets: ParentSets,
    lithology_hexes: dict[str, str],
) -> None:
    """
    Generate the CSV file with the dictionary of parent sets.
    During this stage, the subject for is added to the list of parents for when the
    data is used later.
    The hex code for each subject is also added to the CSV file.
    """
    logger.info("Writing parent sets to: %s", filepath)

    # Sort the dictionary keys
    parent_sets = dict(sorted(parent_sets.items()))

    with open(filepath, "w") as csv_file:
        csvwriter = csv.writer(csv_file)
        # Write the header
        csvwriter.writerow(["simple_lithology_uri", "name", "parents", "hex_colour"])
        # Write the rows
        for subject_label, subject_dict in parent_sets.items():

            # Add the subject to the list of parents for searching later
            subject_dict["parents"].add(subject_label)

            # Convert the set to a sorted JSON list
            parent_list = list(subject_dict["parents"])
            parent_list.sort()
            parent_list_json = json.dumps(parent_list)

            # Get the hex value
            if subject_label in lithology_hexes:
                hex_colour = lithology_hexes[subject_label]
            else:
                hex_colour = None

            csvwriter.writerow([subject_dict["simple_lithology_uri"], subject_label, parent_list_json, hex_colour])


def get_english_label(labels: list[tuple[str, str]]) -> str:
    """
    Get the English label from a list of label tuple objects.
    """
    return [label for label in labels if label.language == "en"][0].toPython()


def create_graph(filepath: Path, graph_dict: GraphDict) -> None:
    """
    Generate a Directed Acyclic Graph based on the broader/parent predicates of each subject.
    """
    # Import is here due to it not being in the usual environment and so is not always installed
    import matplotlib.pyplot as plt  # noqa

    md_graph = nx.MultiDiGraph()

    for predicates in graph_dict.values():
        subject_label = get_english_label(predicates["prefLabel"])
        if "broader" in predicates:
            for parent in predicates["broader"]:
                parent_label = get_english_label(graph_dict[parent.toPython()]["prefLabel"])
                # Nodes are automatically created when an edge is added
                md_graph.add_edge(subject_label, parent_label)

    plt.figure(figsize=(30, 30))
    nx.draw(md_graph, with_labels=True)
    plt.savefig(filepath)
    logger.info("Creating networkx graph: %s", filepath)


if __name__ == "__main__":
    logger.setLevel(logging.INFO)
    main()
