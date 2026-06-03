# Installing CRAG

CRAG comprises a plugin for QGIS:

 - The CRAG plugin is written by BGS and is used to collect data.
   It adds the required GeoPackage database and layers to a project so that data can be collected in BGS format.
   It also provides tools to manage photos, create a field report and validate data.

## Install QGIS

QGIS, and the required plugin, can be installed on Windows, Linux or Mac computers, installation is [described on the QGIS website](https://qgis.org/resources/installation-guide/).


## Install Field Data Capture Plugin

The Field Data Capture plugin can be installed from a zip file via the `Plugins` menu.

Select `Manage and Install Plugins`.

:::{figure-md}
![Plugins Menu](images/plugin_menu.png){align=center}

*Plugins Menu*
:::

Select `Install from ZIP` and choose the ZIP file using the file chooser.

:::{figure-md}
![Add Plugin Repository](images/install_from_zip.png){align=center}

*Install from ZIP*
:::

Click `Install Plugin` and then confirm

:::{figure-md}
![Add Plugin Repository](images/install_from_zip_confirm.png){align=center}

*Confirm Install from ZIP*
:::

Once installed, the plugin can be accessed from the `Plugins` menu and the `Field Data Capture Toolbar`:

:::{figure-md}
![CRAG Menu](images/gdcs_menu.png){align=center}

*Field Data Capture Menu*
:::

:::{figure-md}
![CRAG Toolbar](images/gdcs_toolbar.png){align=center}

*Field Data Capture Toolbar*
:::

:::{note}
If the Field Data Capture plugin toolbar is missing, try disabling and re-enabling it from the Plugin Manager.
:::

### Moving the Plugin Toolbar

By default the plugin toolbar will appear on the last row of the QGIS toolbars.

:::{figure-md}
![Default Plugin Toolbar](images/default_plugin_toolbar.png){align=center}

*Default Plugin Toolbar*
:::

The toolbar can be moved within the main toolbars, or repositioned on any edge of the QGIS window, by dragging the toolbar from its left edge.

:::{subfigure} AB
:subcaptions: below
:gap: 0

![Move Plugin Toolbar](images/move_plugin_toolbar.png)
![Relocated Plugin Toolbar](images/plugin_toolbars.png)

:::

Other QGIS toolbars can also be moved in the same way.
