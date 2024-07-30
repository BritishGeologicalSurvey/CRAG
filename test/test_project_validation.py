from pathlib import Path

import pytest
from qgis.PyQt.QtWidgets import QMessageBox

from plugin.field_data_capture import FieldDataCapture
from plugin.project_validation import (
    ValidationResult,
    ValidationStatus,
    validate_project,
)
from plugin.utils import ipdb_breakpoint  # noqa
from conftest import create_fdc_project_files


@pytest.fixture()
def fdc_project_bad(tmp_path: Path) -> Path:
    """
    Fixture to setup a test project which is purposefully invalid and breaks all validation checks.
    Creates a project with a database which contains some data and photo files.
    """
    project_dir = tmp_path / "fdc_project_invalid"
    feature_filepaths = {
        "photos": [
            Path("test/data/photos/exif_data.jpg"),
            # Does not have a row in the database
            Path("test/data/photos/no_exif_data.jpg"),
        ],
        "media": [],
    }

    create_fdc_project_files(
        project_dir=project_dir,
        insert_data_sql=Path("test/data/fdc_project_invalid.sql"),
        feature_filepaths=feature_filepaths,
    )

    # Add a dummy conflict GeoPackage to the project
    dummy_conflict_gpkg = project_dir / "field-data-capture (conflicted copy).gpkg"
    dummy_conflict_gpkg.touch()

    return project_dir


def test_validate_project_good(fdc_project: FieldDataCapture):
    # Act
    results = validate_project(project_dir=fdc_project.project_dir)

    # Assert
    for result in results:
        assert result.status == ValidationStatus.PASS
        assert result.messages == []


def test_validate_project_bad(fdc_project_bad: Path):
    # Arrange
    expected_results = [
        ValidationResult(
            validation_function="check_features_valid_parents",
            status=ValidationStatus.FAIL,
            messages=[
                "bedrock_line with invalid parent field_project found: algal_band",
                "locality_point with invalid parent field_project found: leorudczenko_002",
            ],
        ),
        ValidationResult(
            validation_function="check_locality_children_valid_parents",
            status=ValidationStatus.FAIL,
            messages=[
                "media with invalid parent locality_point found: file_does_no_exist.mov",
                "sample with invalid parent locality_point found: sample_001",
            ],
        ),
        ValidationResult(
            validation_function="check_field_project_plugin_version",
            status=ValidationStatus.FAIL,
            messages=[
                "field_project does not include a valid plugin version",
            ],
        ),
        ValidationResult(
            validation_function="check_no_conflict_gpkg_exists",
            status=ValidationStatus.WARNING,
            messages=[
                "Conflict GeoPackge file found: field-data-capture (conflicted copy).gpkg",
            ],
        ),
    ]

    # Act
    results = validate_project(project_dir=fdc_project_bad)

    # Assert
    assert expected_results == results


def test_validate_project_plugin_pass(fdc_project: FieldDataCapture):
    # Act
    fdc_project.run_project_validation()

    # Assert
    # The main messsage types have been monkeypatched to be a Mock object
    QMessageBox.information.assert_called_with(
        None,
        "Project Validation",
        "Validation for project 'test_project_dir' passed.",
    )


def test_validate_project_plugin_warning(fdc_project: FieldDataCapture):
    # Arrange
    # Add a dummy conflict GeoPackage to the project
    dummy_conflict_gpkg = fdc_project.project_dir / "field-data-capture (conflicted copy).gpkg"
    dummy_conflict_gpkg.touch()

    # Act
    fdc_project.run_project_validation()

    # Assert
    # The main messsage types have been monkeypatched to be a Mock object
    QMessageBox.warning.assert_called_with(
        None,
        "Project Validation",
        (
            "Validation for project 'test_project_dir' warning.\n\nValidation warning for function: "
            "check_no_conflict_gpkg_exists\n\tConflict GeoPackge file found: field-data-capture (conflicted copy).gpkg"
        ),
    )
