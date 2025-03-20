import json
from collections import defaultdict
from typing import Optional

from qgis.PyQt.QtCore import (
    pyqtSignal,
    Qt,
)
from qgis.PyQt.QtGui import QFont
from qgis.PyQt.QtWidgets import (
    QComboBox,
    QCompleter,
    QDialog,
    QFrame,
    QLabel,
    QRadioButton,
    QVBoxLayout,
)

from .config import FEATURE_TABLES_LINES
from .utils import (  # noqa
    FieldDataCaptureProject,
    ipdb_breakpoint,
)


class LineLayerSelector(QDialog, FieldDataCaptureProject):
    """
    Simple PyQt dialog which allows the user to select a line layer,
    and then a line type within that layer.
    """
    line_layer_selector_confirm = pyqtSignal(str, str)
    line_layer_selector_closed = pyqtSignal()
    recent_lines_no = 6
    default_types = [
        {"layer": "bedrock_line", "type": "bedrock_geology_boundary_inf"},
        {"layer": "bedrock_line", "type": "bedrock_geology_boundary_obs"},
        {"layer": "bedrock_line", "type": "fracture_obs"},
        {"layer": "superficial_line", "type": "superficial_geology_boundary"},
        {"layer": "terrain_line", "type": "concave_break_in_slope"},
        {"layer": "terrain_line", "type": "convex_break_in_slope"},
    ]

    def __init__(self):
        super().__init__()

        self.setWindowTitle("Select Line Type")
        self.setMinimumSize(300, 150)
        self.setWindowFlags(
            Qt.Window | Qt.WindowCloseButtonHint
        )
        self.recent_line_types = self.get_recent_line_types()
        self.layers_to_cats_to_types = self.get_layers_to_categories_to_types()

        self.comboboxes: dict[str, QComboBox] = {}
        self.recent_line_buttons: dict[str, QRadioButton] = {}
        self.setup_ui_elements(self.recent_line_types)
        self.connect_signals_and_slots()

    def get_line_type_layers(self) -> dict[str, str]:
        """
        Return a lookup dictionary of the line layer that contains each line code.
        """
        layer_cat_types = self.get_layers_to_categories_to_types()

        line_type_layers = {}
        for layer in layer_cat_types:
            for line_category in layer_cat_types[layer]:
                for line_type in layer_cat_types[layer][line_category]:
                    # Line types should be unique, but assert just in case
                    assert line_type not in line_type_layers
                    line_type_layers[line_type] = layer

        line_type_layers = dict(sorted(line_type_layers.items()))
        return line_type_layers

    def get_layers_to_categories_to_types(self) -> dict[str, dict[str, list[str]]]:
        """
        Generate a dictionary where the keys are names of each line layer,
        and the values more dictionaries where the keys are line categories from the above layer
        and the values are line types from the above category.
        """
        layers_to_cats_to_types: dict[str, dict[str, list[str]]] = {}

        for line_table in sorted(FEATURE_TABLES_LINES):
            # Get dictionary for line table
            line_name = line_table.replace("_line", "")
            dic_table = f"dic_line_type_{line_name}"

            dic_layer = self.get_fdc_layer(dic_table)

            # Get line categories and type codes from dic layer
            # defaultdict creates new list when categories first appear
            cats_to_codes = defaultdict(list)
            for feature in dic_layer.getFeatures():
                line_category = feature.attribute("category")
                line_code = feature.attribute("code")
                cats_to_codes[line_category].append(line_code)

            # Add category dictionary to layer dictionary
            layers_to_cats_to_types[line_table] = cats_to_codes

        return layers_to_cats_to_types

    def get_recent_line_types(self) -> list[dict[str, str]]:
        """
        Get the recent line types from the QGIS plugin settings.
        Combine them with the default line types if there are not enough.
        """
        recent_line_types = self.get_plugin_setting("recent_line_types")
        if recent_line_types is None:
            recent_line_types = []
        else:
            recent_line_types = json.loads(recent_line_types)

        # Ensure that there are 6 line types by combining all recents with required number of defaults
        recent_line_types = recent_line_types + self.default_types[:self.recent_lines_no - len(recent_line_types)]
        return recent_line_types

    def setup_ui_elements(self, recent_line_types: list[dict[str, str]]) -> None:
        """
        Create the elements of the line layer selector User Interface.
        Also sets the layout for the dialog box.
        """
        # Create main comboboxes
        self.comboboxes["layer"] = QComboBox()
        self.comboboxes["category"] = QComboBox()
        self.comboboxes["type"] = self.create_searchable_combobox()
        # Initial population of comboboxes
        self.update_line_layer_combobox()
        self.update_line_cat_combobox()
        self.update_line_type_combobox()

        # Create dialog layout
        dialog_layout = QVBoxLayout()
        self.setLayout(dialog_layout)

        # Only add the layout for recent line types if some are provided
        if len(recent_line_types) > 0:
            recent_lines_layout = self.create_recent_lines_layout(recent_line_types)
            dialog_layout.addLayout(recent_lines_layout)

        all_lines_layout = self.create_all_lines_layout()
        dialog_layout.addLayout(all_lines_layout)


    def create_searchable_combobox(self) -> QComboBox:
        """
        Create a searchable QComboBox widget.
        """
        combobox = QComboBox()
        combobox.setEditable(True)
        # Don't add the inserted text as an item to the list
        combobox.setInsertPolicy(QComboBox.NoInsert)
        # Popup a list below the text box which shows the ones which do match the search term
        combobox.completer().setCompletionMode(QCompleter.PopupCompletion)
        # Get text items which contain the input text
        combobox.completer().setFilterMode(Qt.MatchContains)
        return combobox


    def update_line_layer_combobox(self) -> None:
        """
        Populate the line_layer_combobox with line layer names.
        """
        # Add default value
        self.comboboxes["layer"].addItem("Select Line Layer", userData=None)
        for line_layer in self.layers_to_cats_to_types:
            self.comboboxes["layer"].addItem(line_layer, userData=line_layer)


    def update_line_cat_combobox(self) -> None:
        """
        Update the values in the line_cat_combobox to be line categories from the selected line layer.
        if the current selection is invalid, reset the items to be default,
        and reset the line_type_combobox to default.
        """
        # Remove all items and then add default one
        self.comboboxes["category"].clear()
        self.comboboxes["category"].addItem("Select Line Category", userData=None)

        # Reset the line_type_combobox
        self.update_line_type_combobox()

        line_layer = self.comboboxes["layer"].currentData()
        if isinstance(line_layer, str):
            for line_category in self.layers_to_cats_to_types[line_layer]:
                self.comboboxes["category"].addItem(line_category, userData=line_category)


    def update_line_type_combobox(self) -> None:
        """
        Update the values in line_type_combobox to be line types from the selected line layer and category.
        If the current selection is invalid, reset the items to default.
        """
        # Remove all items and then add default one
        self.comboboxes["type"].clear()
        self.comboboxes["type"].addItem("", userData=None)

        line_layer = self.comboboxes["layer"].currentData()
        line_category = self.comboboxes["category"].currentData()

        line_type_layers = self.get_line_type_layers()

        # If a valid line layer is given for filtering
        if isinstance(line_layer, str):

            # If a valid category is given, only show line types from the category
            if isinstance(line_category, str):
                for line_type in self.layers_to_cats_to_types[line_layer][line_category]:
                    self.comboboxes["type"].addItem(line_type, userData=line_type)

            # If a valid category is not given, add all lines for the layer instead
            else:
                for line_category in self.layers_to_cats_to_types[line_layer]:
                    for line_type in self.layers_to_cats_to_types[line_layer][line_category]:
                        self.comboboxes["type"].addItem(line_type, userData=line_type)

        else:
            # With no filtering, add all line types
            for line_type in line_type_layers:
                self.comboboxes["type"].addItem(line_type, userData=line_type)


    def create_recent_lines_layout(self, recent_line_types: list[dict[str, str]]) -> QVBoxLayout:
        """
        Create the layout for the recent lines widgets.
        """
        # This is the outer layout which contains all widgets for recent lines
        recent_lines_layout = QVBoxLayout()

        # Add label
        recent_lines_label = self.create_bold_label("Recent Line Types")
        recent_lines_layout.addWidget(recent_lines_label)

        # Add frame for buttons
        recent_lines_frame = self.create_bordered_frame()
        recent_lines_layout.addWidget(recent_lines_frame)

        # Populate inner layout with buttons
        recent_lines_buttons_layout = QVBoxLayout()

        for recent_line_dict in recent_line_types:
            recent_line_button = self.create_recent_line_button(recent_line_dict)
            recent_lines_buttons_layout.addWidget(recent_line_button)
            self.recent_line_buttons[recent_line_dict["type"]] = recent_line_button

        # Put buttons layout into frame
        recent_lines_frame.setLayout(recent_lines_buttons_layout)

        return recent_lines_layout


    def create_recent_line_button(self, line_dict: dict[str, str]) -> QRadioButton:
        """
        Create a button to automatically select the given line type.
        """
        line_button = QRadioButton(line_dict["type"])

        def button_callback():
            if line_button.isChecked():
                self.confirm_selection(line_layer=line_dict["layer"], line_type=line_dict["type"])

        line_button.toggled.connect(button_callback)
        return line_button


    def create_all_lines_layout(self) -> QVBoxLayout:
        """
        Create the layout for all line types widgets.
        """
        # Create labels
        line_type_label = QLabel("Select or search for line type")
        # Inner layout for all line types drop down buttons
        all_lines_buttons_layout = QVBoxLayout()
        all_lines_frame = self.create_bordered_frame()
        all_lines_frame.setLayout(all_lines_buttons_layout)
        # Add button widgets
        all_lines_buttons_layout.addWidget(line_type_label)
        all_lines_buttons_layout.addWidget(self.comboboxes["type"])
        all_lines_buttons_layout.addWidget(self.comboboxes["layer"])
        all_lines_buttons_layout.addWidget(self.comboboxes["category"])
        # Create outer layout for all line types
        all_lines_layout = QVBoxLayout()
        all_lines_label = self.create_bold_label("All Line Types")
        all_lines_layout.addWidget(all_lines_label)
        all_lines_layout.addWidget(all_lines_frame)
        return all_lines_layout


    def create_bordered_frame(self) -> QFrame:
        """
        Create a QFrame with a styled border.
        """
        frame = QFrame()
        frame.setObjectName("MainFrame")
        frame.setFrameShape(QFrame.StyledPanel | QFrame.Plain)
        frame.setStyleSheet("#MainFrame { border: 1px solid silver; }")
        return frame


    def create_bold_label(self, text: str) -> QLabel:
        """
        Create a label with the given text in bold font.
        """
        font = QFont()
        font.setBold(True)
        label = QLabel(text)
        label.setFont(font)
        return label


    def connect_signals_and_slots(self) -> None:
        """
        Function for connecting signals and slots of buttons and input boxes.
        """
        # The line_layer_combobox connects to only the line_cat_combobox and not the line_type_combobox
        # This is because when the line_layer_combobox is updated,
        # it has a cascading effect which triggers the line_cat_combobox to update,
        # and then that update triggers the line_type_combobox to update,
        # thus meaning they are all updated accordingly
        self.comboboxes["layer"].currentTextChanged.connect(self.update_line_cat_combobox)
        self.comboboxes["category"].currentTextChanged.connect(self.update_line_type_combobox)
        # We use the activated signal here because it ignores programmatically changing the combobox
        self.comboboxes["type"].activated.connect(self.confirm_selection)


    def confirm_selection(self, *args, line_layer: Optional[str] = None, line_type: Optional[str] = None) -> None:
        """
        Confirm the current line selection, emit a signal to plugin if it is valid.
        The method takes *args first as it can be called by a button which passes an event.
        """
        # If no values are given, get them from the comboboxes
        if line_layer is None and line_type is None:
            line_layer = self.comboboxes["layer"].currentData()
            line_type = self.comboboxes["type"].currentData()

        # Emit a signal if a line type has been chosen
        if line_type is not None:
            if line_layer is None:
                # If we don't know the line layer, we have to look it up
                line_layer = self.get_line_type_layers()[line_type]

            self.update_recent_line_types(line_layer, line_type)
            self.line_layer_selector_confirm.emit(line_layer, line_type)


    def update_recent_line_types(self, line_layer: str, line_type: str) -> None:
        """
        Update the recent line types saved to the QGIS plugin settings.
        """
        new_recent_line_type = {
            "layer": line_layer,
            "type": line_type,
        }
        # If the new line is already in the list of recent lines,
        # remove the existing one and re-add it to the start of the list
        if new_recent_line_type in self.recent_line_types:
            self.recent_line_types.remove(new_recent_line_type)

        # If 4 recents are already saved, remove the last (oldest) one
        if len(self.recent_line_types) == 6:
            self.recent_line_types.pop(-1)

        # Add selected line type to start of recent list
        self.recent_line_types.insert(0, new_recent_line_type)

        self.set_plugin_setting("recent_line_types", json.dumps(self.recent_line_types))


    def closeEvent(self, event=None) -> None:
        """
        Function which is run by PyQt when the dialog is closed.
        """
        self.line_layer_selector_closed.emit()
