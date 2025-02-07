from typing import Optional

from qgis.PyQt.QtCore import (
    pyqtSignal,
    Qt,
)
from qgis.PyQt.QtWidgets import (
    QComboBox,
    QCompleter,
    QDialog,
    QLabel,
    QMessageBox,
    QVBoxLayout,
)

from .config import FEATURE_TABLES_LINES
from .utils import (  # noqa
    FieldDataCaptureProject,
    set_combobox_index_by_data,
    ipdb_breakpoint,
)


class LineLayerSelector(QDialog, FieldDataCaptureProject):
    """
    Simple PyQt dialog which allows the user to select a line layer,
    and then a line type within that layer.
    """
    line_layer_selector_confirm = pyqtSignal(str, str)
    line_layer_selector_closed = pyqtSignal()

    def __init__(self, preselect_line_type: Optional[dict[str, str]] = None):
        super().__init__()

        self.setWindowTitle("Select Line Type")
        self.setMinimumSize(300, 150)
        self.setWindowFlags(
            Qt.Window | Qt.WindowCloseButtonHint
        )

        self.layers_to_cats_to_types = self.get_layers_to_categories_to_types()

        self.comboboxes: dict[str, QComboBox] = {}
        self.setup_ui_elements()
        self.connect_signals_and_slots()

        if preselect_line_type is not None:
            self.apply_preselect_line_type(preselect_line_type)


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
            # Get line categories and types from dic layer
            cats_to_codes = {}
            for feature in dic_layer.getFeatures():

                # Add category to dictionary first
                line_category = feature.attribute("category")
                if line_category not in cats_to_codes:
                    cats_to_codes[line_category] = []

                # Add type to category list
                cats_to_codes[line_category].append(feature.attribute("code"))

            # Add category dictionary to layer dictionary
            layers_to_cats_to_types[line_table] = cats_to_codes

        return layers_to_cats_to_types


    def setup_ui_elements(self) -> None:
        """
        Create the elements of the line layer selector User Interface.
        Also sets the layout for the dialog box.
        """
        # Create comboboxes
        line_layer_label = QLabel("Line Layer")
        self.comboboxes["layer"] = QComboBox()
        line_cat_label = QLabel("Line Category")
        self.comboboxes["category"] = QComboBox()
        line_type_label = QLabel("Line Type")
        self.comboboxes["type"] = self.create_searchable_combobox()

        # Initial population of comboboxes
        self.update_line_layer_combobox()
        self.update_line_cat_combobox()
        self.update_line_type_combobox()

        # Create layout for lines attributes input
        line_attributes_layout = QVBoxLayout()
        line_attributes_layout.addWidget(line_layer_label)
        line_attributes_layout.addWidget(self.comboboxes["layer"])
        line_attributes_layout.addWidget(line_cat_label)
        line_attributes_layout.addWidget(self.comboboxes["category"])
        line_attributes_layout.addWidget(line_type_label)
        line_attributes_layout.addWidget(self.comboboxes["type"])

        # Create dialog layout
        dialog_layout = QVBoxLayout()
        dialog_layout.addLayout(line_attributes_layout)
        self.setLayout(dialog_layout)


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
        self.comboboxes["type"].addItem("Select Line Type", userData=None)

        line_layer = self.comboboxes["layer"].currentData()
        line_category = self.comboboxes["category"].currentData()
        # If a valid line layer is given
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


    def apply_preselect_line_type(self, preselect_line_type: dict[str, str]) -> None:
        """
        Update the combobox selection to match a given preselection.
        """
        preselected = preselect_line_type.copy()

        # Get category of line type and add it to dictionary
        preselected["category"] = [
            category
            for category, types in self.layers_to_cats_to_types[preselected["layer"]].items()
            if preselected["type"] in types
        ][0]

        # Set the current index of each combobox to be the given preselection
        for line_attribute, combobox in self.comboboxes.items():
            set_combobox_index_by_data(combobox, preselected[line_attribute])


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


    def confirm_selection(self) -> None:
        """
        Confirm the current line selection, emit a signal to plugin if it is valid.
        """
        line_layer = self.comboboxes["layer"].currentData()
        line_type = self.comboboxes["type"].currentData()
        if line_layer is not None and line_type is not None:
            self.line_layer_selector_confirm.emit(line_layer, line_type)
        else:
            QMessageBox.warning(None, "Warning", "Please select a line layer and line type.")


    def closeEvent(self, event=None) -> None:
        """
        Function which is run by PyQt when the dialog is closed.
        """
        self.line_layer_selector_closed.emit()
