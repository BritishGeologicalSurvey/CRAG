"""Script to prepare QGIS repository plugins.xml file from plugin metadata."""
import argparse
from configparser import ConfigParser
from datetime import datetime
import os
from textwrap import dedent
import subprocess

TEMPLATE = dedent("""
    <?xml version = '1.0' encoding = 'UTF-8'?>
    <plugins>
      <pyqgis_plugin name='{name}' version='{version}'>
        <description>{description}</description>
        <version>{version}</version>
        <qgis_minimum_version>3.28</qgis_minimum_version>
        <homepage>{homepage}</homepage>
        <file_name>{file_name}</file_name>
        <author_name>{author}</author_name>
        <download_url>{download_url}</download_url>
        <uploaded_by>{uploaded_by}</uploaded_by>
        <create_date>{create_date}</create_date>
        <update_date>{update_date}</update_date>
      </pyqgis_plugin>
    </plugins>
    """).strip()

REPOSITORY_ROOT = "http://field-data-capture.glpages.ad.nerc.ac.uk/model-and-forms/"
ZIPFILE_NAME = "field_data_capture.zip"
CREATE_DATE = "2023-09-28"


def write_plugins_xml(metadata_file):
    """Write plugins.xml from metadata.txt."""
    metadata = ConfigParser()
    metadata.read(metadata_file)
    metadata = metadata['general']

    with open('plugins.xml', 'wt') as outfile:
        outfile.write(TEMPLATE.format(
            file_name=ZIPFILE_NAME,
            download_url=REPOSITORY_ROOT + '/' + ZIPFILE_NAME,
            uploaded_by=os.getenv('USER'),
            create_date=CREATE_DATE,
            update_date=datetime.now().isoformat(),
            **metadata
        ))


def update_metadata(metadata_file):
    """
    Recreate the metadata file with an updated version number.
    """
    metadata = ConfigParser()
    metadata.read(metadata_file)
    metadata['general']['version'] = get_version()
    with open(metadata_file, 'wt') as f:
        metadata.write(f)


def get_version():
    """
    Return version number based on timestamp and git commit.
    :return:
    """
    result = subprocess.run(['git', 'rev-parse', '--short', 'HEAD'],
                            check=True, capture_output=True, text=True)
    commit = result.stdout.strip()
    timestamp = datetime.now().strftime('%Y%m%d%H%M%S')
    return '{}_{}'.format(timestamp, commit)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Create plugins.xml file from metadata.txt")
    parser.add_argument("metadata_file", help="Location of metadata.txt",
                        type=str)
    args = parser.parse_args()

    update_metadata(args.metadata_file)
    write_plugins_xml(args.metadata_file)
