"""
These are tests for the plugin which depend on a running QGIS version which is supplied by the 'fdc' fixture.
"""
from pathlib import Path

from plugin.field_data_capture import FieldDataCapture


def test_instantiation(fdc):
    assert isinstance(fdc, FieldDataCapture)


def test_project_fixture(fdc: FieldDataCapture, qgs_project: Path):
    # Check the project directory
    assert fdc.project_dir.name == "test_project_dir"
    # Check the qgz file
    files = list(fdc.project_dir.glob("*.qgz"))
    assert len(files) == 1
    assert files[0].name == "test_project.qgz"
