from typing import Any

import pytest

from qgis.PyQt.QtWidgets import QComboBox

from plugin.field_data_capture import FieldDataCapture
from plugin.utils import (
    get_table_rows,
    get_combobox_items_dict,
    set_combobox_index_by_data,
)

COMBOBOX_DATA = {
    "Default": None,
    "Item A": "item_a",
    "Item B": "item_b",
    "Item C": "item_c",
}


@pytest.fixture()
def combobox() -> QComboBox:
    """
    Create and populate QComboBox for tests.
    """
    combobox = QComboBox()
    for label, user_data in COMBOBOX_DATA.items():
        combobox.addItem(label, userData=user_data)
    return combobox


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


def test_get_combobox_items_dict(combobox: QComboBox):
    # Assert
    assert get_combobox_items_dict(combobox) == COMBOBOX_DATA


@pytest.mark.parametrize(
    ["data", "data_set"],
    (
        ("item_a", True),
        ("item_b", True),
        ("item_c", True),
        ("item_d", False),
        ("item_e", False),
    ),
)
def test_set_combobox_index_by_data(
    data: Any,
    data_set: bool,
    combobox: QComboBox,
):
    # Act
    set_combobox_index_by_data(combobox, data)

    # Assert
    assert (combobox.currentData() == data) is data_set
