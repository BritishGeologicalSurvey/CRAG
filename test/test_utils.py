import pytest

from plugin.field_data_capture import FieldDataCapture
from plugin.utils import get_table_rows


@pytest.mark.parametrize(
    "sql, count",
    [("SELECT * FROM field_project", 1),
     ("SELECT *, AsText(CastAutomagic(geometry)) as geom FROM locality_point", 2)]
)
def test_get_rows(fdc_project: FieldDataCapture, sql: str, count: int):
    # Act
    rows = get_table_rows(fdc_project.db_file, sql)

    # Assert
    assert isinstance(rows, list)
    assert len(rows) == count
    assert isinstance(rows[0], dict)
