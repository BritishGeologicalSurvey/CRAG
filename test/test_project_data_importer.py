import re
import sqlite3
from mock import Mock
from pathlib import Path

import pytest
import etlhelper as etl

from bin.project_data_importer import ProjectDataImporter
from plugin.config import FEATURE_TABLES
from plugin.field_data_capture import FieldDataCapture
from conftest import (
    create_fdc_project_files,
    setup_db_conn,
)
from plugin.utils import ipdb_breakpoint  # noqa

DEST_SHORT_NAME = "dest_fdc_project"


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
    project_dir = tmp_path / DEST_SHORT_NAME
    feature_filepaths = {
        "photos": [
            Path("test/data/photos/exif_data.jpg"),
            Path("test/data/photos/no_exif_data.jpg"),
        ],
        "media": [],
    }
    create_fdc_project_files(
        project_dir=project_dir,
        insert_data_sql=Path("test/data/dest_fdc_project.sql"),
        feature_filepaths=feature_filepaths,
        short_name=DEST_SHORT_NAME
    )
    return project_dir


def test_project_data_importer_fixtures(
    src_fdc_project: Path,
    dest_fdc_project: Path,
):
    for project_dir, short_name in [(src_fdc_project, "test_project"),
                                    (dest_fdc_project, DEST_SHORT_NAME)]:
        # Check the files exist
        assert project_dir.exists()
        for subpath in [f"{short_name}.gpkg", "photos", "media"]:
            assert (project_dir / subpath).exists()
        # Check that some photos exist
        assert len(list((project_dir / "photos").rglob("*[!.placeholder]"))) > 0
        # Check that a field_project row exists
        with setup_db_conn(project_dir / f"{short_name}.gpkg") as conn:
            rows = etl.fetchall(
                "SELECT short_name FROM field_project",
                conn,
            )
            assert len(rows) == 1
            assert rows[0]['short_name'] == short_name


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
        "media": 9,
        "photo": 5,
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
        "short_name: test_project",
        "title: test field project title",
        "description: test field project description",
        "project_lead: test_user",
        "start_date: 2024-01-01",
        "end_date: 2024-12-31",
        "local_epsg: 27700",
        "notes: test field project notes",
        "mapped_scale: 25000",
        "recorded_by: leorud",
        "recorded_on: 2024-04-17T14:10:40.374",
        "qgis_plugin_version: test_plugin_version",
    ]
    expected_field_project_notes_metadata = "\n".join(expected_field_project_notes_metadata_lines)
    dest_db = dest_fdc_project / f"{DEST_SHORT_NAME}.gpkg"

    # Configure test case where project notes are null
    if null_field_project_notes:
        with sqlite3.connect(dest_db) as conn:
            conn.enable_load_extension(True)
            etl.execute("""SELECT load_extension("mod_spatialite")""", conn)
            etl.execute("UPDATE field_project SET notes = NULL", conn)
        conn.close()
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

    conn.close()

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
    dest_db = dest_fdc_project / f"{DEST_SHORT_NAME}.gpkg"
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


def test_copy_project_data_failed_metadata(
    src_fdc_project: Path,
    dest_fdc_project: Path,
    monkeypatch
):
    # Record original state of database and photos folder
    dest_db = dest_fdc_project / f"{DEST_SHORT_NAME}.gpkg"
    dest_db_original_contents = dest_db.read_bytes()
    photo_folder_original_contents = list((src_fdc_project / "photos").rglob("*"))

    # Make the copy_src_field_project_metadata throw an error
    project_data_importer = ProjectDataImporter(src_fdc_project, dest_fdc_project)
    bad_copy_src_field_project_metadata = Mock(side_effect=Exception('bad project metadata'))
    monkeypatch.setattr(project_data_importer, 'copy_src_field_project_metadata',
                        bad_copy_src_field_project_metadata)

    # Act
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
    result = project_data_importer.validate_project_databases()
    # Assert 1
    assert result
    # Act 2
    result = project_data_importer.copy_project_data()
    # Assert 2
    assert result


def test_validate_projects_bad_db_missing(
    src_fdc_project: Path,
    dest_fdc_project: Path,
    caplog,
):
    # Arrange
    project_data_importer = ProjectDataImporter(src_fdc_project, dest_fdc_project)
    # Delete the database file in the destination project
    (dest_fdc_project / f"{DEST_SHORT_NAME}.gpkg").unlink()
    # Act 1
    result = project_data_importer.validate_project_databases()
    # Assert 1
    assert not result
    assert "Database file is missing from the dest project" in caplog.text
    # Act 2
    result = project_data_importer.copy_project_data()
    # Assert 2
    assert not result
    assert "Database file is missing from the dest project" in caplog.text


@pytest.mark.parametrize(
    "open_db_file",
    (
        Path(f"{DEST_SHORT_NAME}.gpkg-shm"),
        Path(f"{DEST_SHORT_NAME}.gpkg-wal"),
    ),
)
def test_validate_projects_bad_db_open(
    open_db_file: Path,
    src_fdc_project: Path,
    dest_fdc_project: Path,
    caplog,
):
    # Arrange
    project_data_importer = ProjectDataImporter(src_fdc_project, dest_fdc_project)
    # Create a dummy open database file
    (dest_fdc_project / open_db_file).touch()
    # Act 1
    result = project_data_importer.validate_project_databases()
    # Assert 1
    assert not result
    assert f"The database file in the '{dest_fdc_project.name}' project may be open" in caplog.text
    assert re.search(r'sqlite3 .+\.gpkg vacuum', caplog.text)

    # Act 2
    result = project_data_importer.copy_project_data()
    # Assert 2
    assert not result
    assert f"The database file in the '{dest_fdc_project.name}' project may be open" in caplog.text
    assert re.search(r'sqlite3 .+\.gpkg vacuum', caplog.text)


def test_validate_projects_bad_path_not_a_folder(
    src_fdc_project: Path,
    dest_fdc_project: Path,
    caplog,
):
    # Arrange
    src_geopackage = src_fdc_project / 'test_project.gpkg'
    dest_geopackage = dest_fdc_project / f'{DEST_SHORT_NAME}.gpkg'

    # Act
    # Pass geopackage names instead of project folders
    with pytest.raises(ValueError):
        ProjectDataImporter(src_geopackage, dest_geopackage)

    # Assert
    assert f"src project {src_geopackage} is not a directory" in caplog.text
    assert f"dest project {dest_geopackage} is not a directory" in caplog.text


def test_validate_projects_bad_path_src_and_dest_the_same(
    src_fdc_project: Path,
    caplog,
):
    # Act
    # Pass the src as both arguments
    with pytest.raises(ValueError):
        ProjectDataImporter(src_fdc_project, src_fdc_project)

    # Assert
    assert "Source and destination are the same, they must be different projects" in caplog.text
