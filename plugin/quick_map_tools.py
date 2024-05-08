from typing import Optional

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
from qgis.PyQt.QtCore import pyqtSignal
from qgis.PyQt.QtWidgets import (
    QAction,
    QDesktopWidget,
    QMessageBox,
)
import pyplugin_installer

from .config import LOCALITY_POINT_CHILDREN
from .utils import ipdb_breakpoint  # noqa


class QuickMapToolBase:
    """
    Base class for QuickMapTools used in FieldDataCapture.
    """
    # This stores the mode of the quick map tool which is mainly used to name and identify the tool
    quick_mode: str
    warn_unsaved_locality_data = pyqtSignal()
    to_deactivate = pyqtSignal()

    def __init__(self, iface: QgisInterface, layer: QgsVectorLayer, action: Optional[QAction]):
        """
        Setup the QuickMapTool for fast editing.
        """
        # Setup map tool
        self.setToolName(f"fdc_{layer.name()}_{self.quick_mode}")
        self.iface: QgisInterface = iface
        self._layer: QgsVectorLayer = layer
        if action is not None:
            self.setAction(action)

        # Prepare layer
        self.iface.setActiveLayer(layer)
        if not layer.isEditable():
            layer.startEditing()
        # Connect active layer changed signal to deactivate function in the plugin
        self.iface.layerTreeView().currentLayerChanged.connect(self.to_deactivate)


    def get_plugin_metadata(self) -> dict[str, str]:
        """
        Get the current metadata of the FieldDataCapture plugin from QGIS plugin manager.
        This will reload the plugin manager's current plugin metadata.
        """
        # Update the current metadata for all plugins
        # This will briefly open a dialog window for the plugin manager to be updated
        pyplugin_installer.instance().reloadAndExportData()
        return self.iface.pluginManagerInterface().pluginMetadata("field_data_capture")


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
                    newValue=self.get_plugin_metadata()["version_installed"],
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

    def __init__(self, iface: QgisInterface, layer: QgsVectorLayer, action: Optional[QAction]):
        QgsMapToolDigitizeFeature.__init__(
            self, iface.mapCanvas(), iface.cadDockWidget(),
            mode=self.capture_modes[layer.name()],
        )
        QuickMapToolBase.__init__(self, iface, layer, action)

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
        return capture_modes


    def add_feature(self, geometry_feature: QgsFeature):
        """
        Open the feature form for the layer with the given new feature.
        This is triggered by the 'digitizingCompleted' signal which passes a new empty feature with the geometry.
        """
        # Create feature with the geometry from the new empty feature
        feature = QgsVectorLayerUtils.createFeature(layer=self._layer, geometry=geometry_feature.geometry())
        self._layer.addFeature(feature)
        self.open_feature_form(feature)


class QuickEditTool(QuickMapToolBase, QgsMapToolIdentifyFeature):
    """
    Custom QgsMapTool based on QgsMapToolIdentifyFeature with custom logic to reduce clicks
    when editing an existing feature.
    """
    quick_mode = "edit"

    def __init__(self, iface: QgisInterface, layer: QgsVectorLayer, action: Optional[QAction]):
        QgsMapToolIdentifyFeature.__init__(self, iface.mapCanvas(), layer)
        QuickMapToolBase.__init__(self, iface, layer, action)

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

    def __init__(self, iface: QgisInterface, layer: QgsVectorLayer, action: Optional[QAction]):
        QgsMapToolIdentifyFeature.__init__(self, iface.mapCanvas(), layer)
        QuickMapToolBase.__init__(self, iface, layer, action)

        # Setup map tool
        self.setCursor(QgsApplication.getThemeCursor(QgsApplication.Cursor.CrossHair))
        # This signal fires when the user has clicked on a feature on the map
        self.featureIdentified.connect(self.delete_feature)


    def delete_feature(self, feature: QgsFeature):
        """
        Delete the given feature, asking for confirmation before proceeding.
        """
        point_name = feature.attribute("name")
        result = QMessageBox.question(
            None, "Delete Feature",
            (
                f"Are you sure you want to delete feature '{point_name}'"
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
