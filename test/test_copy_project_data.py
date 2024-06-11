from pathlib import Path

import pytest
import etlhelper as etl

from bin.copy_project_data import CopyProjectData
from plugin.create_gpkg_from_sql import main as gpkg_from_sql
from plugin.field_data_capture import FieldDataCapture
from conftest import setup_db_conn
from plugin.utils import ipdb_breakpoint  # noqa


@pytest.fixture()
def src_fdc_project(fdc_project: FieldDataCapture) -> Path:
    """
    Fixture to setup a test source project for merging 2 projects together.
    Uses the test QGIS project.
    """
    return fdc_project.project_dir


@pytest.fixture()
def dest_fdc_project(tmp_path: Path) -> Path:
    """
    Fixture to setup a test destination project for merging 2 projects together.
    Creates a project with a database which contains some data and photo files.
    """
    # Make the project directory
    project_dir = tmp_path / "dest_fdc_project"
    project_dir.mkdir(exist_ok=True)

    # Make database file
    db_file = project_dir / "field-data-capture.gpkg"
    db_file_data = Path("test/data/dest_fdc_project.sql")
    gpkg_from_sql(db_file=db_file)
    with setup_db_conn(db_file) as conn:
        conn.executescript(db_file_data.read_text())

    # Make feature files directories and copy files into them for testing
    feature_filepaths: dict[str, list[Path]] = {
        "photos": [
            Path("test/data/photos/exif_data.jpg"),
            Path("test/data/photos/no_exif_data.jpg"),
        ],
        "media": [],
    }
    for feature_dir, feature_files in feature_filepaths.items():
        (project_dir / feature_dir).mkdir(exist_ok=True)
        for feature_file in feature_files:
            new_feature_file = project_dir / feature_file.name
            new_feature_file.write_bytes(feature_file.read_bytes())

    return project_dir


def test_copy_project_data_fixtures(
    src_fdc_project: Path,
    dest_fdc_project: Path,
):
    for project_dir in [src_fdc_project, dest_fdc_project]:
        # Check the files exist
        assert project_dir.exists()
        for subpath in ["field-data-capture.gpkg", "photos", "media"]:
            assert (project_dir / subpath).exists()
        # Check that a field_project row exists
        with setup_db_conn(project_dir / "field-data-capture.gpkg") as conn:
            field_project_count = etl.fetchone(
                "SELECT COUNT() AS count FROM field_project",
                conn,
                row_factory=etl.row_factories.tuple_row_factory,
            )[0]
            assert field_project_count == 1
