# Copyright 2026 British Geological Survey
# Licensed under GPLv3 licence
# SPDX-License-Identifier: GPL-3.0-or-later
from qgis.PyQt.QtWidgets import (
    QRadioButton,
    QVBoxLayout,
)

from plugin.crag import Crag
from plugin.settings_dialog import (
    RadioButtonGroup,
    SettingsDialog,
)
from plugin.utils import ipdb_breakpoint  # noqa

RADIO_LABEL = "Select an option"
RADIO_OPTIONS = ["Duck", "Quack", "Honk"]


def test_radio_button_group_init(crag: Crag):
    """
    This test uses the `crag` fixture so that a QApplication is setup, which allows the creation of PyQt widgets.
    """
    # Act
    radio_group = RadioButtonGroup(RADIO_LABEL, RADIO_OPTIONS)

    # Assert
    # Check that the layout is correct
    assert isinstance(radio_group.layout, QVBoxLayout)
    # The first widget should be the label
    assert radio_group.layout.itemAt(0).widget().text() == RADIO_LABEL
    # There should be the same number of buttons as options after the label
    for idx, option_text in enumerate(RADIO_OPTIONS):
        button = radio_group.layout.itemAt(idx + 1).widget()
        assert isinstance(button, QRadioButton)
        assert button.text() == option_text
    # No option should be selected by default
    assert radio_group.get_selection() is None


def test_radio_button_group_default(crag: Crag):
    """
    This test uses the `crag` fixture so that a QApplication is setup, which allows the creation of PyQt widgets.
    """
    # Arrange
    default = RADIO_OPTIONS[1]

    # Act
    radio_group = RadioButtonGroup(RADIO_LABEL, RADIO_OPTIONS, default)

    # Assert
    assert radio_group.get_selection() == default


def test_radio_button_group_get_selection(crag: Crag):
    """
    This test uses the `crag` fixture so that a QApplication is setup, which allows the creation of PyQt widgets.
    """
    # Arrange
    selection_idx = 2
    expected_option = RADIO_OPTIONS[selection_idx]
    radio_group = RadioButtonGroup(RADIO_LABEL, RADIO_OPTIONS)

    # Act
    # Select an option
    radio_group.radio_buttons[selection_idx].toggle()
    actual_option = radio_group.get_selection()

    # Assert
    assert actual_option == expected_option


def test_open_settings_dialog(crag_project: Crag):
    # Act
    result = crag_project.open_settings_dialog()

    # Assert
    assert result
    assert isinstance(crag_project.settings_dialog, SettingsDialog)


def test_close_settings_dialog(crag_project: Crag):
    # Arrange
    crag_project.open_settings_dialog()

    # Act
    crag_project.settings_dialog.cancel_button.click()

    # Assert
    assert crag_project.settings_dialog is None


def test_apply_map_note_option(crag_project: Crag):
    # Arrange
    expected_expression = """
                if(
                    "geology_description" is not null,
                    concat("map_face_note",
                           '\n',
                           "geology_description"),
                    "map_face_note"
                )"""

    # Act 1
    crag_project.open_settings_dialog()

    # Assert 1
    # Default should be False
    assert not crag_project.settings_dialog.map_note_checkbox.isChecked()

    # Act 2
    # Enable extended map face notes and confirm settings
    crag_project.settings_dialog.map_note_checkbox.setChecked(True)
    crag_project.settings_dialog.ok_button.click()

    # Assert 2
    rule = crag_project.get_layer_label_rule("locality_point", "map face note")
    assert rule.settings().isExpression
    assert rule.settings().fieldName == expected_expression
    # Map face note changes are stored in the project
    assert crag_project.project_instance.isDirty()


def test_apply_lines_form_option(crag_project: Crag):
    # Arrange
    expected_option = False

    # Act 1
    crag_project.open_settings_dialog()

    # Assert 1
    # Default should be True
    assert crag_project.settings_dialog.lines_form_checkbox.isChecked()

    # Act 2
    # Disable lines form
    crag_project.settings_dialog.lines_form_checkbox.setChecked(expected_option)
    crag_project.settings_dialog.ok_button.click()

    # Assert 2
    assert crag_project.get_plugin_setting("show_lines_form") is expected_option
    # Line tool changes aren't store in the project
    assert not crag_project.project_instance.isDirty()
