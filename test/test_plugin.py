"""
These are tests for the plugin which depend on a running QGIS version which is supplied by the 'fdc' fixture.
"""
from plugin.field_data_capture import FieldDataCapture


def test_instantiation(fdc):
    assert isinstance(fdc, FieldDataCapture)
