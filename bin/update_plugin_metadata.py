# Copyright 2026 UKRI / British Geological Survey
# Licensed under GPLv3 licence
# SPDX-License-Identifier: GPL-3.0-or-later
"""Script to update the plugin metadata file with the version number."""
import argparse
import subprocess
from configparser import ConfigParser


def update_metadata(metadata_file):
    """
    Recreate the metadata file with an updated version number.
    """
    metadata = ConfigParser()
    # Use the following setting to preserve the case of "options", i.e. keys.
    # The QGIS plugin repository is case-sensitive.
    metadata.optionxform = lambda option: option
    metadata.read(metadata_file)
    metadata['general']['version'] = _get_version()
    with open(metadata_file, 'wt') as f:
        metadata.write(f)


def get_zip_file_name_env():
    """
    Return zip file name filename.
    """
    tag = _get_version()
    filename_env = f'PLUGIN_FILE_NAME=crag_{tag}.zip'
    return filename_env


def _get_version():
    """
    Return version number based on tag.
    :return:
    """
    result = subprocess.run(['git', 'tag', '--points-at', 'HEAD'],
                            check=True, capture_output=True, text=True)
    tag = result.stdout.strip()
    return tag


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Update the plugin metadata.txt and config file version.")
    parser.add_argument("metadata_file", help="Location of metadata.txt",
                        type=str)
    args = parser.parse_args()

    update_metadata(args.metadata_file)
    filename_env = get_zip_file_name_env()
    print(filename_env)
