from typing import Optional

from qgis.PyQt.QtCore import (
    pyqtSignal,
    Qt,
)
from qgis.PyQt.QtWidgets import (
    QButtonGroup,
    QCheckBox,
    QDialog,
    QGroupBox,
    QHBoxLayout,
    QLabel,
    QPushButton,
    QRadioButton,
    QVBoxLayout,
)

from .utils import (  # noqa
    FieldDataCaptureProject,
    ipdb_breakpoint,
)


class RadioButtonGroup:
    """
    Class for automatically creating a group of QRadioButton widgets in a QVBoxLayout.
    """
    def __init__(self, label: str, options: list[str], default: Optional[str] = None):
        # Create layout
        self.layout = QVBoxLayout()

        # Create label
        self.label = QLabel(label)
        self.layout.addWidget(self.label)

        self.default = default
        self.group = QButtonGroup()
        self.radio_buttons: list[QRadioButton] = []
        # Create radio buttons
        for option in options:
            radio_button = QRadioButton(option)
            # ButtonGroups set the exclusivity of buttons
            self.group.addButton(radio_button)
            self.radio_buttons.append(radio_button)
            self.layout.addWidget(radio_button)

            # Apply default option
            if option == self.default:
                radio_button.setChecked(True)


    def get_selection(self) -> str | None:
        """
        Get the currently selected radio button string option.
        Returns None if no option is selected.
        """
        selected_options = [
            radio_button.text()
            for radio_button in self.radio_buttons
            if radio_button.isChecked()
        ]
        if len(selected_options) == 0:
            return None
        return selected_options[0]


class SettingsDialog(QDialog, FieldDataCaptureProject):
    """
    Simple PyQt dialog which allows the user to change their plugin settings.
    """
    settings_dialog_closed = pyqtSignal()

    def __init__(self):
        super().__init__()

        self.setWindowTitle("Settings")
        self.setWindowFlags(
            Qt.WindowType.Window | Qt.WindowType.WindowCloseButtonHint
        )

        self.map_note_options = {
            False: "map_face_note",
            True: """
                if(
                    "geology_description" is not null,
                    concat("map_face_note",
                           '\n',
                           "geology_description"),
                    "map_face_note"
                )""",
        }
        self.options_to_bools = {
            "Off": False,
            "On": True,
        }

        self.setup_ui_elements()
        self.connect_signals_and_slots()

    def setup_ui_elements(self) -> None:
        """
        Create the elements of the line layer selector User Interface.
        Also sets the layout for the dialog box.
        """
        # Create radio buttons
        self.map_note_checkbox = self.create_map_note_checkbox()
        self.lines_form_checkbox = self.create_lines_form_checkbox()

        # Radio buttons groupbox settings
        project_settings_group = QGroupBox("Project Settings")
        project_settings_layout = QVBoxLayout()
        project_settings_layout.addWidget(self.map_note_checkbox)
        project_settings_group.setLayout(project_settings_layout)
        user_settings_group = QGroupBox("User Settings")
        user_settings_layout = QVBoxLayout()
        user_settings_layout.addWidget(self.lines_form_checkbox)
        user_settings_group.setLayout(user_settings_layout)

        # Create buttons
        self.ok_button = QPushButton("OK")
        self.cancel_button = QPushButton("Cancel")

        # Create buttons layout
        button_layout = QHBoxLayout()
        button_layout.addWidget(self.ok_button)
        button_layout.addWidget(self.cancel_button)

        # Create dialog layout
        dialog_layout = QVBoxLayout()
        dialog_layout.addWidget(project_settings_group)
        dialog_layout.addWidget(user_settings_group)
        dialog_layout.addLayout(button_layout)
        self.setLayout(dialog_layout)

    def create_map_note_checkbox(self) -> QCheckBox:
        """
        Create the CheckBox for the map face note options.
        """
        rule = self.get_layer_label_rule(layer="locality_point", label_description="map face note")
        current_expression = rule.settings().fieldName

        # Swap dict keys and values
        expressions_to_options = dict((v, k) for k, v in self.map_note_options.items())
        # Default option is False
        current_option = expressions_to_options.get(current_expression, False)

        map_note_checkbox = QCheckBox(text="Extended map face notes")
        map_note_checkbox.setChecked(current_option)
        return map_note_checkbox

    def apply_map_note_option(self) -> None:
        """
        Apply the selected option for the map face note.
        """
        option = self.map_note_checkbox.isChecked()
        layer = "locality_point"
        rule = self.get_layer_label_rule(layer=layer, label_description="map face note")
        # If the selection is different, update it
        if rule.settings().fieldName != self.map_note_options[option]:
            # Ensure that it is treated as an expression
            rule.settings().isExpression = True
            rule.settings().fieldName = self.map_note_options[option]
            self.get_fdc_layer(layer).triggerRepaint()
            # Mark project as dirty so that users are asked to save changes
            self.project_instance.setDirty()

    def create_lines_form_checkbox(self) -> QCheckBox:
        """
        Create the Check Box for the lines form options.
        """
        current_option = self.get_plugin_setting("show_lines_form")
        # Default option is True
        if current_option is None:
            current_option = True

        lines_form_checkbox = QCheckBox(text="Show attribute form for new lines")
        lines_form_checkbox.setChecked(current_option)
        return lines_form_checkbox


    def apply_lines_form_option(self) -> None:
        """
        Apply the selected lines form option.
        """
        option = self.lines_form_checkbox.isChecked()
        self.set_plugin_setting("show_lines_form", option)


    def connect_signals_and_slots(self) -> None:
        """
        Function for connecting signals and slots of buttons and input boxes.
        """
        self.ok_button.clicked.connect(self.apply_settings)
        self.cancel_button.clicked.connect(self.close)

    def apply_settings(self) -> None:
        """
        Apply the selected settings in the dialog.
        """
        self.apply_map_note_option()
        self.apply_lines_form_option()
        self.close()

    def closeEvent(self, event=None) -> None:
        """
        Function which is run by PyQt when the dialog is closed.
        """
        self.settings_dialog_closed.emit()
