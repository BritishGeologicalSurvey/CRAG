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
)
from qgis.gui import (
    QgisInterface,
    QgsAttributeDialog,
    QgsMapToolDigitizeFeature,
    QgsMapToolIdentify,
)
from qgis.PyQt.QtCore import (
    pyqtSignal,
    QItemSelectionModel,
    QModelIndex,
    QSortFilterProxyModel,
)
from qgis.PyQt.QtWidgets import (
    QAction,
    QMessageBox,
)

from .config import (
    FEATURE_STR_IDENTIFIERS,
    FEATURE_TABLES_LINES,
    LOCALITY_POINT_CHILDREN,
    TABLE_LIST,
)
from .utils import (  # noqa
    FieldDataCaptureProject,
    create_prepopulated_feature,
    ipdb_breakpoint,
)


class QuickMapToolBase(FieldDataCaptureProject):
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
        tool_name: str,
        action: Optional[QAction],
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

        self.prepare_layer()
        # Connect active layer changed signal to deactivate function in the plugin
        self.iface.layerTreeView().currentLayerChanged.connect(self.to_deactivate)
        # Connect editingStopped signal from all given layers to deactivate function in the plugin
        for layer in self.get_layer():
            layer.editingStopped.connect(self.to_deactivate)


    def get_layer(self) -> list[QgsVectorLayer]:
        """
        Get the current layer(s) in a list.
        This avoids having to check if the current layer is a list first.
        """
        if isinstance(self._layer, QgsVectorLayer):
            return [self._layer]
        else:
            return self._layer


    def prepare_layer(self) -> None:
        """
        Prepare the layer for quick editing.
        This includes making it editable and setting it as the active layer.
        """
        # PyQGIS does not provide a method for selecting mutliple layers in the tree view
        # Therefore we go into the root PyQt5 objects and find the elements we want from the widget
        view = self.iface.layerTreeView()
        model = view.model()

        # Firstly, clear current selection
        view.selectionModel().clear()

        all_model_indexes = self.recursive_find_selection_model_indexes(start_index=model)
        for vector_layer in self.get_layer():
            if not vector_layer.isEditable():
                vector_layer.startEditing()
            # Select the layer in the layerTreeView
            layer_index = all_model_indexes[vector_layer.name()]
            view.selectionModel().setCurrentIndex(layer_index, QItemSelectionModel.Select)


    def recursive_find_selection_model_indexes(
        self,
        start_index: QSortFilterProxyModel | QModelIndex,
        valid_indexes: Optional[dict[str, QModelIndex]] = None,
    ) -> dict[str, QModelIndex]:
        """
        Recursively search the given model/model index to find all other valid child indexes.
        This is used on the iface.layerTreeView().model() object to return all child indexes.
        This essentially means it returns all of the child index elements of the layerTreeView.
        This does also mean that child line_types will be included in this list, not only layers.
        Returns a dictionary of index data names as values and index objects as keys.
        """
        if valid_indexes is None:
            valid_indexes = {}

        # Only add QModelIndex child objects to the list, the root QSortFilterProxyModel object has no data
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


    def open_feature_form(
        self,
        feature: QgsFeature,
        feature_layer: QgsVectorLayer,
        reopen_form_on_add_locality: bool = True,
    ) -> None:
        """
        Open the feature form for the given feature in a modal state.
        Also handles the auto saving of the layer if the user confirms the form.
        If the tool is locality_point_add, then the option to reopen the form can be used too.
        """
        dialog = self.open_custom_feature_form(feature, feature_layer)

        # Connect accpeted/rejected signals to their callback functions
        # One of these signals is always sent when the dialog is closed, regardless of how it is closed
        # Which means they are more reliable than the form button signals
        # Because the user can press their 'Esc' key to not press any form buttons
        dialog.accepted.connect(lambda: self.save_feature_form(
            dialog,
            feature,
            feature_layer,
            reopen_form_on_add_locality,
        ))
        dialog.rejected.connect(lambda: self.rollback_feature_form(feature_layer))


    def open_custom_feature_form(self, feature: QgsFeature, feature_layer: QgsFeature) -> QgsAttributeDialog:
        """
        Open the required feature form the the given feature.
        This will set the dialog to be modal and have a dynamic size according to the screen resolution.
        Any changes to the given feature are made by this form.
        Returns the newly created dialog.
        """
        # Get the dialog from the iface
        # This ensures the dialog is setup properly for the given layer and feature
        dialog = self.iface.getFeatureForm(feature_layer, feature)

        # Remove the menu bar from the dialog
        # Removing the widget from the layout does not actually remove it from display
        # The simplest way to do this is to set the parent to None
        dialog.layout().menuBar().setParent(None)

        # Adjust the minimum size of the dialog
        screen_geometry = self.iface.mainWindow().screen().availableGeometry()
        # Set the dialog size based on the screen size
        size_modifier = 0.75
        # We either use a modified dimension size based on the screen size
        # or a set maximum size for the dimension, whichever is smaller
        dialog_width_min = int(min(screen_geometry.width() * size_modifier, 1000))
        dialog_height_min = int(min(screen_geometry.height() * size_modifier, 800))
        dialog.setMinimumSize(dialog_width_min, dialog_height_min)

        # Don't use exec due to a QGIS bug/change with forms
        # Opening a child feature form from the parent closes them both
        dialog.setModal(True)
        dialog.show()

        # Adjust the position of the dialog to be in the centre of the current screen
        # This means it will be at the centre of QGIS when full screen,
        # and still in an optimial position for sizing when QGIS is shrunk to a smaller size
        # Moving or resizing the dialog does not work unless the dialog is already being shown
        # We add the screen left/top coordinates to the result to account for multiple screens
        x_pos = int((screen_geometry.width() - dialog_width_min) / 2) + screen_geometry.left()
        y_pos = int((screen_geometry.height() - dialog_height_min) / 2) + screen_geometry.top()
        dialog.move(x_pos, y_pos)
        # Resize the dialog to the minimum for the screen after moving it
        # This ensures that Windows does not resize the dialog automatically if
        # we have moved it across different screens with different resolutions
        dialog.resize(dialog_width_min, dialog_height_min)

        return dialog


    def save_feature_form(
        self,
        dialog: QgsAttributeDialog,
        feature: QgsFeature,
        feature_layer: QgsVectorLayer,
        reopen_form_on_add_locality: bool = True,
    ) -> None:
        """
        Save the changes from the given dialog for the given feature.
        This also runs any special handling for specific layers after saving.
        """
        # Update the feature with the attributes from the dialog's feature
        feature.setAttributes(dialog.feature().attributes())
        # Get the uuid of the new feature so we can find the new feature again after saving
        # We can't use the fid as this will be set once it is saved
        new_feature_uuid = feature.attribute("uuid")
        feature_layer.commitChanges(stopEditing=False)
        # Get the saved new feature
        new_feature = list(feature_layer.getFeatures(expression=f""""uuid" = '{new_feature_uuid}'"""))[0]

        # Post digitization operations
        self.canvas().refresh()

        # Special handling for locality_point
        if feature_layer.name() == "locality_point":
            # Reopen the form for a new point to show all tabs
            if self.quick_mode == "add" and reopen_form_on_add_locality:
                # Set reopen_form to False to prevent an infinite loop
                self.open_feature_form(new_feature, feature_layer, reopen_form_on_add_locality=False)
            else:
                self.warn_unsaved_locality_data.emit()

        # Special handling for field_project
        # Deactivate the tool after adding a new feature
        if feature_layer.name() == "field_project" and self.quick_mode == "add":
            self.to_deactivate.emit()


    def rollback_feature_form(self, feature_layer: QgsVectorLayer) -> None:
        """
        Rollback the changes after a feature dialog has been rejected for the given layer.
        This also reactivates the current map tool.
        """
        feature_layer.rollBack()
        # Re-enable editing and the current tool
        # rollBack disables editing which then triggers the tool to deactivate too
        feature_layer.startEditing()
        self.iface.mapCanvas().setMapTool(self)

        # Post digitization operations
        self.canvas().refresh()


    def get_layer_from_feature(self, feature: QgsFeature) -> QgsVectorLayer:
        """
        Get the layer for the given feature.
        """
        for layer_id in QgsProject.instance().mapLayers():
            layer = QgsProject.instance().mapLayer(layer_id)
            if layer.name() in TABLE_LIST and feature in list(layer.getFeatures()):
                return layer


class QuickMapToolIdentifyBase:
    """
    This is an additional base class which is used in QuickEditTool and QuickDeleteTool.
    Both of these tools need to identify features in a different way to the QuickAddTool,
    and use a universal signal which would conflict with the QuickAddTool.
    """
    identified_feature = pyqtSignal(QgsFeature, QgsVectorLayer)

    def canvasReleaseEvent(self, event) -> None:
        """
        Get the feature from the given event coordinates.
        Emits the feature and it's layer to the identified_feature signal.
        """
        # Get first result from top
        results = super().identify(event.x(), event.y(), self.get_layer(), QgsMapToolIdentify.TopDownAll)
        if len(results) > 0:
            feature = results[0].mFeature
            feature_layer = self.get_layer_from_feature(feature)

            self.identified_feature.emit(feature, feature_layer)


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
        tool_name: str,
        action: Optional[QAction],
        prepopulate: Optional[dict[str, Any]] = None,
        *args,
        **kwargs,
    ):
        QgsMapToolDigitizeFeature.__init__(
            self, iface.mapCanvas(), iface.cadDockWidget(),
            mode=self.capture_modes[layer.name()],
        )
        QuickMapToolBase.__init__(self, iface, layer, tool_name, action)

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
        default_values = self.get_default_values()
        # Add default values to temp prepopulate dictionary so that we can apply both in 1 loop
        if self.prepopulate is not None:
            prepopulate = self.prepopulate | default_values
        else:
            prepopulate = default_values

        feature = create_prepopulated_feature(
            layer=self._layer,
            prepopulate=prepopulate,
            geometry=geometry_feature.geometry(),
        )

        self._layer.addFeature(feature)
        self.open_feature_form(feature, feature_layer=self._layer)


    def get_default_values(self) -> dict[str, Any]:
        """
        Get the default values which should be prepopulated in a new feature.
        The styles do not always apply these when using QuickMapTools.
        """
        default_values = {}
        # Add tool can only take a single layer, so do not need to check if it is a list when checking name

        if self._layer.name() == "locality_point":
            # Get default value for locality_type_code
            locality_type_code = "locality_type_code"
            locality_type_codes = [
                feature.attribute(locality_type_code)
                for feature in self._layer.getFeatures()
            ]
            if len(locality_type_codes) > 0:
                default_values[locality_type_code] = locality_type_codes[-1]

        elif self._layer.name() == "field_project":
            # Get default value for qgis_plugin_version
            default_values["qgis_plugin_version"] = self.get_local_version()

        return default_values


class QuickEditTool(QuickMapToolBase, QuickMapToolIdentifyBase, QgsMapToolIdentify):
    """
    Custom QgsMapTool based on QgsMapToolIdentifyFeature with custom logic to reduce clicks
    when editing an existing feature.
    """
    quick_mode = "edit"

    def __init__(
        self,
        iface: QgisInterface,
        layer: QgsVectorLayer | list[QgsVectorLayer],
        tool_name: str,
        action: Optional[QAction],
        *args,
        **kwargs,
    ):
        QgsMapToolIdentify.__init__(self, iface.mapCanvas())
        QuickMapToolBase.__init__(self, iface, layer, tool_name, action)

        # Setup map tool
        self.setCursor(QgsApplication.getThemeCursor(QgsApplication.Cursor.Identify))
        # This signal fires when the user has clicked on a feature on the map
        self.identified_feature.connect(self.edit_feature)


    def edit_feature(self, feature: QgsFeature, feature_layer: QgsVectorLayer):
        """
        Open the feature form for the given feature.
        This is triggered by the 'featureIdentified' signal which passes an identified feature.
        """
        self.open_feature_form(feature, feature_layer)


class QuickDeleteTool(QuickMapToolBase, QuickMapToolIdentifyBase, QgsMapToolIdentify):
    """
    Custom QgsMapTool based on QgsMapToolIdentifyFeature with custom logic to reduce clicks
    when deleting an existing feature.
    """
    quick_mode = "delete"

    def __init__(
        self,
        iface: QgisInterface,
        layer: QgsVectorLayer | list[QgsVectorLayer],
        tool_name: str,
        action: Optional[QAction],
        *args,
        **kwargs,
    ):
        QgsMapToolIdentify.__init__(self, iface.mapCanvas())
        QuickMapToolBase.__init__(self, iface, layer, tool_name, action)

        # Setup map tool
        self.setCursor(QgsApplication.getThemeCursor(QgsApplication.Cursor.CrossHair))
        # This signal fires when the user has clicked on a feature on the map
        self.identified_feature.connect(self.delete_feature)


    def delete_feature(self, feature: QgsFeature, feature_layer: QgsVectorLayer):
        """
        Delete the given feature, asking for confirmation before proceeding.
        """
        # Get string identifier of feature to display to user
        feature_identifier = feature.attribute(FEATURE_STR_IDENTIFIERS[feature_layer.name()])

        result = QMessageBox.question(
            None, "Delete Feature",
            (
                f"Are you sure you want to delete feature '{feature_identifier}'"
                f" and any child features from layer '{feature_layer.name()}'?"
            ),
        )

        if result == QMessageBox.Yes:
            # We have to setup a new DeleteContext object which is used to perform a cascade delete programmatically
            context = QgsVectorLayer.DeleteContext(cascade=True, project=QgsProject.instance())
            feature_layer.deleteFeature(fid=feature.attribute("fid"), context=context)

            # Save the child layers first for locality_point deletions
            if feature_layer.name() == "locality_point":
                # Save the child layers first
                for child_layer_name in LOCALITY_POINT_CHILDREN:
                    child_layer = self.get_fdc_layer(child_layer_name)
                    if child_layer.isModified():
                        child_layer.commitChanges()

            # Save the parent layer last
            feature_layer.commitChanges(stopEditing=False)
