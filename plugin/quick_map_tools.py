from configparser import ConfigParser
from pathlib import Path
from typing import (
    Any,
    Optional,
)

from qgis.core import (
    QgsApplication,
    QgsFeature,
    QgsProject,
    QgsVectorLayer,
    QgsVectorLayerUtils,
)
from qgis.gui import (
    QgisInterface,
    QgsMapToolDigitizeFeature,
    QgsMapToolIdentifyFeature,
)
from qgis.PyQt.QtCore import (
    pyqtSignal,
    QItemSelectionModel,
    QModelIndex,
    QSortFilterProxyModel,
)
from qgis.PyQt.QtWidgets import (
    QAction,
    QDesktopWidget,
    QMessageBox,
)

from .config import (
    FEATURE_TABLES_LINES,
    LOCALITY_POINT_CHILDREN,
)
from .utils import ipdb_breakpoint  # noqa


class QuickMapToolBase:
    """
    Base class for QuickMapTools used in FieldDataCapture.
    """
    # This stores the mode of the quick map tool which is mainly used to name and identify the tool
    quick_mode: str
    warn_unsaved_locality_data = pyqtSignal()
    to_deactivate = pyqtSignal()

    def __init__(
        self,
        iface: QgisInterface,
        layer: QgsVectorLayer | list[QgsVectorLayer],
        action: Optional[QAction],
        tool_name: str,
    ):
        """
        Setup the QuickMapTool for fast editing.
        """
        # Setup map tool
        self.setToolName(tool_name)
        self.iface: QgisInterface = iface
        self._layer: QgsVectorLayer | list[QgsVectorLayer] = layer
        if action is not None:
            self.setAction(action)

        self.prepare_layer(layer)
        # Connect active layer changed signal to deactivate function in the plugin
        self.iface.layerTreeView().currentLayerChanged.connect(self.to_deactivate)


    def prepare_layer(self, layer: QgsVectorLayer | list[QgsVectorLayer]) -> None:
        """
        Prepare the layer for quick editing.
        This includes making it editable and setting it as the active layer.
        """
        if isinstance(layer, QgsVectorLayer):
            layer = [layer]

        # PyQGIS does not provide a method for selecting mutliple layers in the tree view
        # Therefore we go into the root PyQt5 objects and find the elements we want from the widget
        view = self.iface.layerTreeView()
        model = view.model()

        # Firstly, clear current selection
        view.selectionModel().clear()

        all_model_indexes = self.recursive_find_selection_model_indexes(start_index=model)
        for vector_layer in layer:
            if not vector_layer.isEditable():
                vector_layer.startEditing()
            # Select the layer in the layerTreeView
            layer_index = all_model_indexes[vector_layer.name()]
            view.selectionModel().setCurrentIndex(layer_index, QItemSelectionModel.Select)


    def recursive_find_selection_model_indexes(
        self,
        start_index: QSortFilterProxyModel | QModelIndex,
        valid_indexes: Optional[dict[str, QModelIndex]] = None,
    ) -> list[QModelIndex]:
        """
        Recursively search the given model/ model index to find all other valid child indexes.
        This is used on the iface.layerTreeView().model() object to return all child indexes.
        This essentially means it returns all of the child index elements of the layerTreeView.
        This does also mean that child line_types will be included in this list, not only layers.
        """
        if valid_indexes is None:
            valid_indexes = {}

        if isinstance(start_index, QModelIndex) and start_index.data() is not None:
            valid_indexes[start_index.data()] = start_index

        # The method used to get children differs between the single root object and all other child objects
        if isinstance(start_index, QModelIndex):
            child_method = start_index.child
        elif isinstance(start_index, QSortFilterProxyModel):
            child_method = start_index.index

        index_int = 0
        # Whilst the incrementing index_int value is still finding children with valid data
        while child_method(index_int, 0).data() is not None:
            # The start_index is theoretically a table with columns and rows
            # But the layerTreeView only has columns, and so we only increment the first index
            self.recursive_find_selection_model_indexes(child_method(index_int, 0), valid_indexes)
            index_int += 1

        return valid_indexes


    def get_local_version(self) -> str:
        """
        Get the plugin version from the metadat.txt file written at deployment.
        The metadata file is at the same level as this Python file.
        """
        local_metadata_file = Path(__file__).parent / 'metadata.txt'
        metadata = ConfigParser()
        metadata.read(local_metadata_file)
        try:
            version = metadata['general']['version']
        except KeyError:
            version = 'unknown_version'
        return version


    def open_feature_form(self, feature: QgsFeature, reopen_form_on_add_locality: bool = True):
        """
        Open the feature form for the given feature in a modal state.
        Also handles the auto saving of the layer if the user confirms the form.
        If the tool is locality_point_add, then the option to reopen the form can be used too.
        """
        save = self.open_custom_feature_form(feature)

        # Handle saving or rollback
        if save:
            # For field_project features, add the plugin version to the new feature
            if self._layer.name() == "field_project" and self.quick_mode == "add":
                field_index = [field.name() for field in self._layer.fields()].index("qgis_plugin_version")
                # Even though it is a temporary feature, we can use it's negative fid value from .id() to identify it
                self._layer.changeAttributeValue(
                    fid=feature.id(),
                    field=field_index,
                    newValue=self.get_local_version(),
                )

            # Get the uuid of the new feature so we can find the new feature again after saving
            # We can't use the fid as this will be set once it is saved
            new_feature_uuid = feature.attribute("uuid")
            self._layer.commitChanges(stopEditing=False)
            # Get the saved new feature
            new_feature = list(self._layer.getFeatures(expression=f""""uuid" = '{new_feature_uuid}'"""))[0]

        else:
            self._layer.rollBack()
            # Re-enable editing and the current tool
            # rollBack disables editing which then triggers the tool to deactivate too
            self._layer.startEditing()
            self.iface.mapCanvas().setMapTool(self)

        # Post digitization operations
        self.canvas().refresh()

        # Special handling for locality_point
        if self._layer.name() == "locality_point":
            # Reopen the form for a new point to show all tabs
            if save and self.quick_mode == "add" and reopen_form_on_add_locality:
                # Set reopen_form to False to prevent an infinite loop
                self.open_feature_form(new_feature, reopen_form_on_add_locality=False)
            else:
                self.warn_unsaved_locality_data.emit()

        # Special handling for field_project
        # Deactivate the tool after adding a new feature
        if self._layer.name() == "field_project" and save and self.quick_mode == "add":
            self.to_deactivate.emit()


    def open_custom_feature_form(self, feature: QgsFeature) -> bool:
        """
        Open the required feature form the the given feature.
        This will set the dialog to be modal and have a dynamic size according to the screen resolution.
        Any changes to the given feature are made by this form.
        Returns a boolean indicating True if the user pressed Ok or False if the user pressed Cancel.
        """
        # Get the dialog from the iface
        # This ensures the dialog is setup properly for the given layer and feature
        dialog = self.iface.getFeatureForm(self._layer, feature)
        # Get the screen size of the primary screen
        screen_size = QDesktopWidget().screenGeometry(0).size()
        # Set the dialog size based on the screen size
        size_modifier = 0.75
        # We either use a modified dimension size based on the screen size
        # or a set maximum size for the dimension, whichever is smaller
        width = int(min(screen_size.width() * size_modifier, 1000))
        height = int(min(screen_size.height() * size_modifier, 800))
        dialog.setMinimumSize(width, height)

        # Remove the menu bar from the dialog
        # Removing the widget from the layout does not actually remove it from display
        # The simplest way to do this is to set the parent to None
        dialog.layout().menuBar().setParent(None)

        # Use exec so it is modal
        result = dialog.exec()
        # Update the feature with the attributes from the dialog's feature
        feature.setAttributes(dialog.feature().attributes())

        return result


class QuickAddTool(QuickMapToolBase, QgsMapToolDigitizeFeature):
    """
    Custom QgsMapTool based on QgsMapToolDigitizeFeature with custom logic to reduce clicks
    when digitizing a new feature.
    """
    quick_mode = "add"

    def __init__(
        self,
        iface: QgisInterface,
        layer: QgsVectorLayer,
        action: Optional[QAction],
        tool_name: str,
        prepopulate: Optional[dict[str, Any]] = None,
        *args,
        **kwargs,
    ):
        QgsMapToolDigitizeFeature.__init__(
            self, iface.mapCanvas(), iface.cadDockWidget(),
            mode=self.capture_modes[layer.name()],
        )
        QuickMapToolBase.__init__(self, iface, layer, action, tool_name)

        self.prepopulate = prepopulate
        # Setup map tool
        self.setCursor(QgsApplication.getThemeCursor(QgsApplication.Cursor.CapturePoint))
        # This signal fires when the user has finished drawing some geometry on the map
        self.digitizingCompleted.connect(self.add_feature)


    @property
    def capture_modes(self) -> dict[str, QgsMapToolDigitizeFeature.CaptureMode]:
        """
        Dictionary matching layer names to capture modes.
        """
        qgis_capture_mode = QgsMapToolDigitizeFeature.CaptureMode
        capture_modes = {
            "locality_point": qgis_capture_mode.CapturePoint,
            "field_project": qgis_capture_mode.CapturePolygon,
        }
        for line_table in FEATURE_TABLES_LINES:
            capture_modes[line_table] = qgis_capture_mode.CaptureLine
        return capture_modes


    def add_feature(self, geometry_feature: QgsFeature):
        """
        Open the feature form for the layer with the given new feature.
        This is triggered by the 'digitizingCompleted' signal which passes a new empty feature with the geometry.
        """
        # Get the prepopulate values by field index instead of field name so they can be used by QgsVectorLayerUtils
        prepopulate_indexed = {}
        if self.prepopulate is not None:
            for field_name, prepopulate_value in self.prepopulate.items():
                field_index = [field.name() for field in self._layer.fields()].index(field_name)
                prepopulate_indexed[field_index] = prepopulate_value

        # Create feature with the geometry from the new empty feature and prepopulate any values required
        feature = QgsVectorLayerUtils.createFeature(
            layer=self._layer,
            geometry=geometry_feature.geometry(),
            attributes=prepopulate_indexed,
        )
        self._layer.addFeature(feature)
        self.open_feature_form(feature)


class QuickEditTool(QuickMapToolBase, QgsMapToolIdentifyFeature):
    """
    Custom QgsMapTool based on QgsMapToolIdentifyFeature with custom logic to reduce clicks
    when editing an existing feature.
    """
    quick_mode = "edit"

    def __init__(
        self,
        iface: QgisInterface,
        layer: QgsVectorLayer | list[QgsVectorLayer],
        action: Optional[QAction],
        tool_name: str,
        *args,
        **kwargs,
    ):
        if isinstance(layer, list):
            qgs_layer = None
        else:
            qgs_layer = layer
        QgsMapToolIdentifyFeature.__init__(self, iface.mapCanvas(), qgs_layer)
        QuickMapToolBase.__init__(self, iface, layer, action, tool_name)

        # Setup map tool
        self.setCursor(QgsApplication.getThemeCursor(QgsApplication.Cursor.Identify))
        # This signal fires when the user has clicked on a feature on the map
        self.featureIdentified.connect(self.edit_feature)


    def edit_feature(self, feature: QgsFeature):
        """
        Open the feature form for the given feature.
        This is triggered by the 'featureIdentified' signal which passes an identified feature.
        """
        self.open_feature_form(feature)


class QuickDeleteTool(QuickMapToolBase, QgsMapToolIdentifyFeature):
    """
    Custom QgsMapTool based on QgsMapToolIdentifyFeature with custom logic to reduce clicks
    when deleting an existing feature.
    """
    quick_mode = "delete"

    def __init__(
        self,
        iface: QgisInterface,
        layer: QgsVectorLayer | list[QgsVectorLayer],
        action: Optional[QAction],
        tool_name: str,
        *args,
        **kwargs,
    ):
        if isinstance(layer, list):
            qgs_layer = None
        else:
            qgs_layer = layer
        QgsMapToolIdentifyFeature.__init__(self, iface.mapCanvas(), qgs_layer)
        QuickMapToolBase.__init__(self, iface, layer, action, tool_name)

        # Setup map tool
        self.setCursor(QgsApplication.getThemeCursor(QgsApplication.Cursor.CrossHair))
        # This signal fires when the user has clicked on a feature on the map
        self.featureIdentified.connect(self.delete_feature)


    def delete_feature(self, feature: QgsFeature):
        """
        Delete the given feature, asking for confirmation before proceeding.
        """
        # Get string identifier of feature to display to user
        identifier_fields = {
            "locality_point": "name",
        }
        for line_table in FEATURE_TABLES_LINES:
            identifier_fields[line_table] = "line_type_code"
        feature_identifier = feature.attribute(identifier_fields[self._layer.name()])

        result = QMessageBox.question(
            None, "Delete Feature",
            (
                f"Are you sure you want to delete feature '{feature_identifier}'"
                f" and any child features from layer '{self._layer.name()}'?"
            ),
        )

        if result == QMessageBox.Yes:
            # We have to setup a new DeleteContext object which is used to perform a cascade delete programmatically
            context = QgsVectorLayer.DeleteContext(cascade=True, project=QgsProject.instance())
            self._layer.deleteFeature(fid=feature.attribute("fid"), context=context)

            # Save the child layers first for locality_point deletions
            if self._layer.name() == "locality_point":
                # Save the child layers first
                for child_layer_name in LOCALITY_POINT_CHILDREN:
                    child_layer = QgsProject.instance().mapLayersByName(child_layer_name)[0]
                    if child_layer.isModified():
                        child_layer.commitChanges()

            # Save the parent layer last
            self._layer.commitChanges(stopEditing=False)
