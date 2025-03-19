from qgis.PyQt.QtWidgets import (
    QRadioButton,
    QVBoxLayout,
)

from plugin.field_data_capture import FieldDataCapture
from plugin.settings_dialog import (
    RadioButtonGroup,
    SettingsDialog,
)
from plugin.utils import ipdb_breakpoint  # noqa

RADIO_LABEL = "Select an option"
RADIO_OPTIONS = ["Duck", "Quack", "Honk"]


def test_radio_button_group_init(fdc: FieldDataCapture):
    """
    This test uses the `fdc` fixture so that a QApplication is setup, which allows the creation of PyQt widgets.
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


def test_radio_button_group_default(fdc: FieldDataCapture):
    """
    This test uses the `fdc` fixture so that a QApplication is setup, which allows the creation of PyQt widgets.
    """
    # Arrange
    default = RADIO_OPTIONS[1]

    # Act
    radio_group = RadioButtonGroup(RADIO_LABEL, RADIO_OPTIONS, default)

    # Assert
    assert radio_group.get_selection() == default


def test_radio_button_group_get_selection(fdc: FieldDataCapture):
    """
    This test uses the `fdc` fixture so that a QApplication is setup, which allows the creation of PyQt widgets.
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


def test_open_settings_dialog(fdc_project: FieldDataCapture):
    # Act
    result = fdc_project.open_settings_dialog()

    # Assert
    assert result
    assert isinstance(fdc_project.settings_dialog, SettingsDialog)


def test_close_settings_dialog(fdc_project: FieldDataCapture):
    # Arrange
    fdc_project.open_settings_dialog()

    # Act
    fdc_project.settings_dialog.cancel_button.click()

    # Assert
    assert fdc_project.settings_dialog is None


def test_apply_map_note_option(fdc_project: FieldDataCapture):
    # Arrange
    expected_expression = """
                if(
                    "geology_description" is not null,
                    concat("map_face_note",
                           '\n',
                           "geology_description"),
                    "map_face_note"
                )"""
    fdc_project.open_settings_dialog()

    # Act
    # Enable extended map face notes and confirm settings
    fdc_project.settings_dialog.map_note_radio_group.radio_buttons[1].toggle()
    fdc_project.settings_dialog.ok_button.click()

    # Assert
    rule = fdc_project.get_layer_label_rule("locality_point", "map face note")
    assert rule.settings().isExpression
    assert rule.settings().fieldName == expected_expression
