import sqlite3
from pathlib import Path

import pytest
import etlhelper as etl

from bin.project_data_importer import ProjectDataImporter
from plugin.config import FEATURE_TABLES
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
        project_feature_dir = project_dir / feature_dir
        project_feature_dir.mkdir(exist_ok=True)

        for idx, feature_file in enumerate(feature_files):
            # Put the first file into a sub directory of the feature directory to ensure it is still copied
            if idx == 0:
                new_feature_file = project_feature_dir / "sub_dir" / feature_file.name
                new_feature_file.parent.mkdir(parents=True, exist_ok=True)
            else:
                new_feature_file = project_feature_dir / feature_file.name
            new_feature_file.write_bytes(feature_file.read_bytes())

    return project_dir


def test_project_data_importer_fixtures(
    src_fdc_project: Path,
    dest_fdc_project: Path,
):
    for project_dir in [src_fdc_project, dest_fdc_project]:
        # Check the files exist
        assert project_dir.exists()
        for subpath in ["field-data-capture.gpkg", "photos", "media"]:
            assert (project_dir / subpath).exists()
        # Check that some photos exist
        assert len(list((project_dir / "photos").rglob("*[!.placeholder]"))) > 0
        # Check that a field_project row exists
        with setup_db_conn(project_dir / "field-data-capture.gpkg") as conn:
            field_project_count = etl.fetchone(
                "SELECT COUNT() AS count FROM field_project",
                conn,
                row_factory=etl.row_factories.tuple_row_factory,
            )[0]
            assert field_project_count == 1


@pytest.mark.parametrize('null_field_project_notes', [False, True])
def test_copy_project_data_good(
    src_fdc_project: Path,
    dest_fdc_project: Path,
    null_field_project_notes: bool
):
    # Arrange
    expected_row_counts = {
        "artificial_line": 2,
        "bedrock_line": 1,
        "field_project": 1,
        "lithology": 5,
        "locality_point": 4,
        "manmade_landform": 2,
        "mass_move_line": 1,
        "media": 2,
        "photo": 4,
        "sample": 2,
        "structural_measurement": 2,
        "superficial_landform": 2,
        "superficial_line": 1,
        "terrain_line": 1,
    }
    expected_field_project_fuid = "{3a68b7c7-e3a9-4a35-8dd2-00d31c515244}"
    expected_field_project_notes_metadata_lines = [
        "These are some empty notes honk",
        "",
        "--- Imported Project Metadata ---",
        "short_name: test_field_project",
        "title: test field project title",
        "description: test field project description",
        "project_lead: test_user",
        "status_code: active",
        "start_date: 2024-01-01",
        "end_date: 2024-12-31",
        "field_project_type: field_work",
        "local_epsg: 27700",
        "notes: test field project notes",
        "mapped_scale: 25000",
        "user_entered: leorud",
        "date_entered: 2024-04-17T14:10:40.374",
        "user_updated: None",
        "date_updated: None",
        "qgis_plugin_version: test_plugin_version",
    ]
    expected_field_project_notes_metadata = "\n".join(expected_field_project_notes_metadata_lines)
    dest_db = dest_fdc_project / "field-data-capture.gpkg"

    # Configure test case where project notes are null
    if null_field_project_notes:
        with sqlite3.connect(dest_db) as conn:
            conn.enable_load_extension(True)
            etl.execute("""SELECT load_extension("mod_spatialite")""", conn)
            etl.execute("UPDATE field_project SET notes = NULL", conn)
        expected_field_project_notes_metadata = "\n".join(expected_field_project_notes_metadata_lines[2:])

    # Act
    project_data_importer = ProjectDataImporter(src_fdc_project, dest_fdc_project)
    result = project_data_importer.copy_project_data()

    # Assert
    assert result
    with sqlite3.connect(dest_db) as conn:
        # Check that there are the correct number of rows per table in the destination database
        for table, expected_row_count in expected_row_counts.items():
            row_count = etl.fetchone(
                f"SELECT COUNT() AS count FROM {table}",
                conn,
                row_factory=etl.row_factories.tuple_row_factory,
            )[0]
            assert row_count == expected_row_count

        # Check field_project_fuid values have been transformed so there is only 1
        feature_tables = FEATURE_TABLES - {"field_project"}
        for table in feature_tables:
            field_project_fuids = etl.fetchall(
                f"SELECT field_project_fuid FROM {table} GROUP BY field_project_fuid",
                conn,
                row_factory=etl.row_factories.tuple_row_factory,
            )
            assert len(field_project_fuids) == 1
            assert field_project_fuids[0][0] == expected_field_project_fuid

        # Check that the project metadata has been saved to the notes
        field_project_notes = etl.fetchone(
            "SELECT notes FROM field_project",
            conn,
            row_factory=etl.row_factories.tuple_row_factory,
        )[0]
        assert field_project_notes == expected_field_project_notes_metadata

    # Check that the photo files have been copied across
    for photo_file in (src_fdc_project / "photos").rglob("*[!.placeholder]"):
        assert (dest_fdc_project / photo_file.relative_to(src_fdc_project)).exists()


@pytest.mark.parametrize(
    ["sql_break_db_query"],
    [
        (
            # Change one of the locality_point names to match one of the test points
            # This will cause the copy to fail as it does not abide by the UNIQUE constraint
            "UPDATE locality_point SET name='test_point_002' WHERE name='leorudczenko_002'",
        ),
        (
            # Remove the table bedrock_line
            "DROP TABLE bedrock_line",
        ),
        (
            # Delete one of the line_type_code values that is used
            "DELETE FROM dic_line_type_artificial WHERE code='artificial_geology_boundary'",
        ),
    ],
)
def test_copy_project_data_bad(
    sql_break_db_query: str,
    src_fdc_project: Path,
    dest_fdc_project: Path,
):
    # Break the database in some way
    dest_db = dest_fdc_project / "field-data-capture.gpkg"
    with setup_db_conn(dest_db) as conn:
        etl.execute(sql_break_db_query, conn)

    # Record original state of database and photos folder
    dest_db_original_contents = dest_db.read_bytes()
    photo_folder_original_contents = list((src_fdc_project / "photos").rglob("*"))

    # Act
    project_data_importer = ProjectDataImporter(src_fdc_project, dest_fdc_project)
    result = project_data_importer.copy_project_data()
    photo_folder_contents = list((src_fdc_project / "photos").rglob("*"))

    # Assert that function returns False and original state is unchanged
    assert not result
    assert dest_db.read_bytes() == dest_db_original_contents
    assert photo_folder_contents == photo_folder_original_contents


def test_validate_projects_good(
    src_fdc_project: Path,
    dest_fdc_project: Path,
):
    # Arrange
    project_data_importer = ProjectDataImporter(src_fdc_project, dest_fdc_project)
    # Act 1
    result = project_data_importer.validate_projects()
    # Assert 1
    assert result
    # Act 2
    result = project_data_importer.copy_project_data()
    # Assert 2
    assert result


def test_validate_projects_bad_db_missing(
    src_fdc_project: Path,
    dest_fdc_project: Path,
):
    # Arrange
    project_data_importer = ProjectDataImporter(src_fdc_project, dest_fdc_project)
    # Delete the database file in the destination project
    (dest_fdc_project / "field-data-capture.gpkg").unlink()
    # Act 1
    result = project_data_importer.validate_projects()
    # Assert 1
    assert not result
    # Act 2
    result = project_data_importer.copy_project_data()
    # Assert 2
    assert not result


@pytest.mark.parametrize(
    "open_db_file",
    (
        Path("field-data-capture.gpkg-shm"),
        Path("field-data-capture.gpkg-wal"),
    ),
)
def test_validate_projects_bad_db_open(
    open_db_file: Path,
    src_fdc_project: Path,
    dest_fdc_project: Path,
):
    # Arrange
    project_data_importer = ProjectDataImporter(src_fdc_project, dest_fdc_project)
    # Create a dummy open database file
    (dest_fdc_project / open_db_file).touch()
    # Act 1
    result = project_data_importer.validate_projects()
    # Assert 1
    assert not result
    # Act 2
    result = project_data_importer.copy_project_data()
    # Assert 2
    assert not result
