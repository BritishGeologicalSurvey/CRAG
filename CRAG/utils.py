# Copyright 2026 UKRI / British Geological Survey
# Licensed under GPLv3 licence
# SPDX-License-Identifier: GPL-3.0-or-later
import logging
import sqlite3
import sys
from pathlib import Path
from typing import (
    Any,
    Optional,
)

from qgis.core import (
    QgsGeometry,
    QgsExpressionContext,
    QgsFeature,
    QgsVectorLayer,
    QgsVectorLayerUtils,
)
from qgis.PyQt.QtCore import (
    Qt,
    pyqtRemoveInputHook,
)
from qgis.PyQt.QtGui import (
    QPixmap,
)
from qgis.PyQt.QtWidgets import (
    QComboBox,
    QCompleter,
    QDialog,
    QFrame,
    QHBoxLayout,
    QLabel,
    QMessageBox,
    QPushButton,
    QTextEdit,
    QToolButton,
    QVBoxLayout,
    QWidget,
)


class MultilineMessageBox(QDialog):
    """
    QDialog for displaying a message with additional multiline text.
    If the given text is None, will display a dialog without the multiline text widget.
    """
    def __init__(self, title: str, icon: QMessageBox.Icon, message: str, text: Optional[str] = None):
        super().__init__()
        self.setWindowTitle(title)
        self.setWindowFlags(
            Qt.WindowType.Window | Qt.WindowType.WindowCloseButtonHint
        )
        self.setup_ui_elements()
        self.apply_message(icon, message, text)
        self.exec()

    @staticmethod
    def information(title: str, message: str, text: Optional[str] = None) -> None:
        return MultilineMessageBox(title, QMessageBox.Icon.Information, message, text)

    @staticmethod
    def warning(title: str, message: str, text: Optional[str] = None) -> None:
        return MultilineMessageBox(title, QMessageBox.Icon.Warning, message, text)

    @staticmethod
    def critical(title: str, message: str, text: Optional[str] = None) -> None:
        return MultilineMessageBox(title, QMessageBox.Icon.Critical, message, text)


    def setup_ui_elements(self) -> None:
        """
        Create the elements of the MultilineMessageBox window.
        Also sets the layout for the dialog box.
        """
        self.message_icon = QLabel()
        self.message_label = QLabel()

        self.text_edit = QTextEdit()
        self.text_edit.setReadOnly(True)
        self.text_edit.hide()

        self.ok_button = QPushButton("OK")
        self.ok_button.clicked.connect(lambda: self.closeEvent(None))

        # Create layout for icon and main label
        icon_layout = QHBoxLayout()
        icon_layout.addWidget(self.message_icon)
        icon_layout.addSpacing(10)
        icon_layout.addWidget(self.message_label)
        icon_layout.addStretch(1)
        icon_layout.setContentsMargins(*(10,) * 4)

        # Create dialog layout
        dialog_layout = QVBoxLayout()
        dialog_layout.addLayout(icon_layout)
        dialog_layout.addWidget(self.text_edit)
        dialog_layout.addWidget(self.ok_button, alignment=Qt.AlignmentFlag.AlignRight)
        self.setLayout(dialog_layout)


    def apply_message(self, icon: QMessageBox.Icon, message: str, text: Optional[str]) -> None:
        """
        Update the widgets with the given message and text.
        """
        self.message_icon.setPixmap(get_msgbox_icon_pixmap(icon))
        self.message_label.setText(message)
        # Only show the multiline area if there is multiline text
        if text:
            self.setMinimumWidth(500)
            self.text_edit.setText(text)
            self.text_edit.show()


class CollapsibleWidget(QWidget):
    """
    QWidget object to create a custom collapsible style widget in PyQt.
    See here for additional information:
    https://stackoverflow.com/questions/52615115/how-to-create-collapsible-box-in-pyqt
    """
    def __init__(self, title: str = ""):
        super().__init__()
        self.setup_ui_elements(title)
        self.connect_signals_and_slots()


    def setup_ui_elements(self, title: str) -> None:
        """
        Create the elements of the CollapsibleWidget with a public facing layout.
        """
        self.toggle_button = QToolButton(text=title, checkable=True)
        self.toggle_button.setStyleSheet("QToolButton {border: none;}")
        self.toggle_button.setToolButtonStyle(Qt.ToolButtonStyle.ToolButtonTextBesideIcon)
        self.toggle_button.setArrowType(Qt.ArrowType.RightArrow)

        self.collapsible_layout = QVBoxLayout()
        self.collapsible_layout_widget = QWidget()
        self.collapsible_layout_widget.setHidden(True)
        self.collapsible_layout_widget.setLayout(self.collapsible_layout)

        # Put the layout into a frame for a border
        frame_layout = QVBoxLayout()
        frame = QFrame()
        frame.setFrameStyle(QFrame.Shape.Panel)
        frame.setStyleSheet("QFrame {border: 1px solid gray;}")
        frame.setLayout(frame_layout)

        frame_layout.addWidget(self.toggle_button)
        frame_layout.addWidget(self.collapsible_layout_widget)

        layout = QVBoxLayout()
        layout.addWidget(frame)
        self.setLayout(layout)


    def connect_signals_and_slots(self) -> None:
        """
        Function for connecting signals and slots of buttons and input boxes.
        """
        self.toggle_button.toggled.connect(self.on_click)


    def on_click(self, *args) -> None:
        """
        Switch the arrow type and hide/show the collapsible layout.
        """
        if self.toggle_button.isChecked():
            arrow = Qt.ArrowType.DownArrow
            hide = False
        else:
            arrow = Qt.ArrowType.RightArrow
            hide = True
        self.collapsible_layout_widget.setHidden(hide)
        self.toggle_button.setArrowType(arrow)


class SearchableComboBox(QComboBox):
    """
    A searchable version of a QComboBox widget.
    """
    def __init__(self):
        super().__init__()
        self.setEditable(True)
        # Don't add the inserted text as an item to the list
        self.setInsertPolicy(QComboBox.InsertPolicy.NoInsert)
        # Popup a list below the text box which shows the ones which do match the search term
        self.completer().setCompletionMode(QCompleter.CompletionMode.PopupCompletion)
        # Get text items which contain the input text
        self.completer().setFilterMode(Qt.MatchFlag.MatchContains)


def get_table_rows(db_file: Path, sql: str) -> list[dict[str, Any]]:
    """
    Get the rows from the given database file using the given SQL query.
    The rows are created using a dictionary row factory.
    """
    def dict_factory(cursor, row):
        """
        See https://docs.python.org/3/library/sqlite3.html#sqlite3-howto-row-factory
        """
        fields = [column[0] for column in cursor.description]
        return dict(zip(fields, row))

    rows = []
    with sqlite3.connect(db_file) as conn:
        conn.enable_load_extension(True)
        conn.execute("SELECT load_extension('mod_spatialite');")
        conn.row_factory = dict_factory
        cursor = conn.cursor()
        cursor.execute(sql)
        rows = cursor.fetchall()
    conn.close()

    return rows


def set_combobox_index_by_data(combobox: QComboBox, data: Any) -> None:
    """
    Set the index of a given combobox to be the index at which the given data is found,
    if it is found.
    """
    combobox_item_dict = get_combobox_items_dict(combobox)
    data_items = list(combobox_item_dict.values())
    if data in data_items:
        combobox.setCurrentIndex(data_items.index(data))


def get_combobox_items_dict(combobox: QComboBox) -> dict[str, Any]:
    """
    Get a dictionary of the items from a given QComboBox object.
    The keys are the displayed labels, whilst the values are the actual data.
    """
    model = combobox.model()
    label_to_data = {
        combobox.itemText(row_idx): combobox.itemData(row_idx)
        for row_idx in range(model.rowCount())
    }
    return label_to_data


def create_prepopulated_feature(
    layer: QgsVectorLayer,
    prepopulate: dict[str, Any],
    geometry: QgsGeometry = QgsGeometry(),
    context: QgsExpressionContext = None
) -> QgsFeature:
    """
    Create a new feature for the given layer using the given prepopulated values.
    This means it the feature will have the default values from the layer, and the given prepopulated values.
    """
    prepopulate_indexed = {}
    for field_name, prepopulate_value in prepopulate.items():
        field_index = [field.name() for field in layer.fields()].index(field_name)
        prepopulate_indexed[field_index] = prepopulate_value

    # Create feature with the geometry from the new empty feature and prepopulate any values required
    feature = QgsVectorLayerUtils.createFeature(
        layer=layer,
        geometry=geometry,
        attributes=prepopulate_indexed,
        context=context
    )
    return feature


def get_msgbox_icon_pixmap(icon: QMessageBox.Icon) -> QPixmap:
    """
    Get the pixmap of the given QMessageBox icon.
    This is required because the QMessageBox.Icon object is not a standard QIcon.
    Therefore the simplest way to access it's pixmap is by adding it to a temporary QMessageBox,
    and then get the icon pixmap from that QMessageBox.
    """
    tmp_msgbox = QMessageBox()
    tmp_msgbox.setIcon(icon)
    pixmap = tmp_msgbox.iconPixmap()
    return pixmap


def ipdb_breakpoint():
    """
    Drops code into IPython debugger when QGIS is run from command line.
    Otherwise returns an error.  Press 'c' to *continue* running code.
    """
    try:
        import ipdb  # noqa - don't import at top level as isn't in default QGIS install

        # Switch off unwanted IPython loggers
        for lib in ('asyncio', 'parso'):
            logging.getLogger(lib).setLevel(logging.WARNING)

        pyqtRemoveInputHook()
        # Manually get the frame, so that we can get set_trace at the point this function was called
        # Rather than set_trace in this function itself
        frame = sys._getframe().f_back
        ipdb.set_trace(frame=frame)
    except ModuleNotFoundError:
        pass
