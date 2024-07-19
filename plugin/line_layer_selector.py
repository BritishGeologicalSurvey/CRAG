from qgis.core import QgsProject
from qgis.PyQt.QtCore import (
    pyqtSignal,
    Qt,
)
from qgis.PyQt.QtWidgets import (
    QComboBox,
    QDialog,
    QHBoxLayout,
    QLabel,
    QMessageBox,
    QPushButton,
    QVBoxLayout,
)

from .config import FEATURE_TABLES_LINES
from .utils import ipdb_breakpoint  # noqa


class LineLayerSelector(QDialog):
    """
    Simple PyQt dialog which allows the user to select a line layer,
    and then a line type within that layer.
    """
    line_layer_selector_confirm = pyqtSignal(str, str)
    line_layer_selector_closed = pyqtSignal()
    selected_layer_changed = pyqtSignal()

    def __init__(self):
        super().__init__()

        self.setWindowTitle("Select Line Type")
        self.setMinimumSize(300, 150)
        self.setWindowFlags(
            Qt.Window | Qt.WindowCloseButtonHint
        )

        self.layers_to_codes = self.get_layers_to_codes()

        self.setup_ui_elements()
        self.connect_signals_and_slots()


    def get_layers_to_codes(self) -> dict[str, list[str]]:
        """
        Generate a dictionary where the keys are names of each line layer,
        and the values are the line types for each respective line layer.
        """
        layers_to_codes = {}

        for line_table in FEATURE_TABLES_LINES:
            # Get dictionary for line table
            line_name = line_table.replace("_line", "")
            dic_table = f"dic_line_type_{line_name}"

            # Get line types from dictionary
            dic_layer = QgsProject.instance().mapLayersByName(dic_table)[0]
            line_types = [
                feature.attribute("code")
                for feature in dic_layer.getFeatures()
            ]

            layers_to_codes[line_table] = line_types

        return layers_to_codes


    def setup_ui_elements(self) -> None:
        """
        Create the elements of the line layer selector User Interface.
        Also sets the layout for the dialog box.
        """
        line_layer_label = QLabel("Line Layer")
        self.line_layer_combobox = QComboBox()
        # Add default value
        self.line_layer_combobox.addItem("Select Line Layer", userData=None)
        for line_layer in self.layers_to_codes:
            self.line_layer_combobox.addItem(line_layer, userData=line_layer)

        line_cat_label = QLabel("Line Category")

        line_type_label = QLabel("Line Type")
        self.line_type_combobox = QComboBox()
        # Add default value
        self.line_type_combobox.addItem("Select Line Type", userData=None)
        for line_type_list in self.layers_to_codes.values():
            for line_type in line_type_list:
                self.line_type_combobox.addItem(line_type, userData=line_type)

        line_attributes_layout = QVBoxLayout()
        line_attributes_layout.addWidget(line_layer_label)
        line_attributes_layout.addWidget(self.line_layer_combobox)
        line_attributes_layout.addWidget(line_type_label)
        line_attributes_layout.addWidget(self.line_type_combobox)

        self.ok_button = QPushButton("OK")
        self.cancel_button = QPushButton("Cancel")
        button_layout = QHBoxLayout()
        button_layout.addWidget(self.ok_button)
        button_layout.addWidget(self.cancel_button)

        dialog_layout = QVBoxLayout()
        dialog_layout.addLayout(line_attributes_layout)
        dialog_layout.addLayout(button_layout)
        self.setLayout(dialog_layout)


    def connect_signals_and_slots(self) -> None:
        """
        Function for connecting signals and slots of buttons and input boxes.
        """
        self.ok_button.clicked.connect(self.confirm_selection)
        self.cancel_button.clicked.connect(self.close)


    def create_child_combobox(self, field: str, parent_combobox: QComboBox) -> QComboBox:
        """
        Create a 'child' combobox where it's values are automatically filtered
        based on the value of the given parent combobox.
        """


    def update_line_type_combobox(self, line_layer: str | None) -> None:
        """
        Update the values in line_type_combobox to be line types from the given layer.
        If None is given, the current values will be removed other than the default one.
        """


    def confirm_selection(self) -> None:
        """
        Confirm the current line selection, emit a signal to plugin if it is valid.
        """
        line_layer = self.line_layer_combobox.currentData()
        line_type = self.line_type_combobox.currentData()
        if line_layer is not None and line_type is not None:
            self.line_layer_selector_confirm.emit(line_layer, line_type)
        else:
            QMessageBox.warning(None, "Warning", "Please select a line layer and line type.")


    def closeEvent(self, event=None) -> None:
        """
        Function which is run by PyQt when the dialog is closed.
        """
        self.line_layer_selector_closed.emit()
