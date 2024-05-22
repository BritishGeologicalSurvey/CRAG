# model-and-forms plugin

> This repository contains code for a QGIS plugin to add the field data capture layers to a QGIS project and additional tools for using QGIS in the field.

Scripts are required to:

+ Build a geopackage containing the field data capture data model
+ Run tests on the constraints, views and triggers within the data model
+ Add the field data capture layers to an open QGIS project
+ Configure forms within QGIS for the field data capture layers
+ Configure QGIS to have minimal interface for ease of use on tablets

## Mergin Maps projects

Development of the field data capture system will follow this pattern:

> Data model updates -> QGIS/Mergin project configured by hand -> QGIS plugin implements automatic config

There is lots of exploratory work to do in terms of QGIS project configuration.
This will require multiple QGIS projects to be created.
We will share these projects via Mergin Maps so that they can be tested and feedback collected.

See the [Versions and Feedback](https://kwvmxgit.ad.nerc.ac.uk/field-data-capture/model-and-forms/-/wikis/versions-and-feedback) page on the Wiki for details.

## File Downloads

- [ER Diagram](https://kwvmxgit.ad.nerc.ac.uk/field-data-capture/model-and-forms/-/jobs/artifacts/main/raw/er-diagram.png?job=publish_artifacts)
- [Field Data Capture GPKG](https://kwvmxgit.ad.nerc.ac.uk/field-data-capture/model-and-forms/-/jobs/artifacts/main/raw/field-data-capture.gpkg?job=publish_artifacts)

## ER Diagram

There are 3 "primary key" columns on the data tables.  `fid` is used by QGIS/Geopackage, `objectid` is used by ESRI products.  We let the respective tools populate those and consider them unstable as the `fid` can change during Mergin Maps syncing process.  The `uuid` column is the unique key used to define parent-child relationships.

Note that all tables also have `user_added`, `date_added`, `user_updated` and `date_updated` columns.

![ER Diagram](https://kwvmxgit.ad.nerc.ac.uk/field-data-capture/model-and-forms/-/jobs/artifacts/main/raw/er-diagram.png?job=publish_artifacts)

## Overall philosophy

The plugin in this repository should contain everything that is required to set up a field data capture project in QGIS.
There are a few overarching principles to bear in mind during development:

+ This is not an application, it is a GeoPackage and QGIS configuration optimised for geological field data capture.  The aim of the plugin is to automate the creation of the GeoPackage and Forms.
+ Once created, a project should function by itself, without requiring custom logic from the plugin.
+ At some point, this plugin is likely to be shared with overseas partners - it should not depend on BGS infrastructure nor on Mergin Maps and the liklihood of future translation requirements should be kept in mind.
+ If it is shared, it may be open sourced.  Code should be written in the assumption that the world will be able to see it.  No BGS infrastructure or credentials should be present.
+ Overseas partners may not have an internal data store for map creation.  The option to extend to inclusion of polygons for creation of a final map should be kept open.

## Plugin

### Installing the QGIS plugin

1. Enable the repository in QGIS via _Plugins > Manage and Install Plugins > Settings > Plugin Repositories > Add_
2. Set the Name to "Field Data Capture"
3. Set the URL to http://field-data-capture.glpages.ad.nerc.ac.uk/model-and-forms/plugins.xml
4. Press OK
5. Search for and install `Field Data Capture` in the _All_ tab

The plugin can then be launched from the _Plugins_ menu.  When new versions are released they will be shown in the _Upgradeable_ tab.

### Running the plugin

Once installed, the plugin is available at _Plugins > Field Data Capture_.

## For Developers

### Running scripts

> The development environment is Linux under WSL. It assumes you have Conda installed via the WSL ansible role.

To install OS system dependencies:

```bash
sudo apt install graphviz graphviz-dev build-essential spatialite-bin libsqlite3-mod-spatialite -y
```

 - spatialite provides access to spatial features that are used by some of the GeoPackage index triggers.
 - graphviz is used to generate the ER diagram.

Create a virtual environment (Python 3.12) and install dependencies:

```bash
conda env create -f environment.yml
```

It is beneficial to install the `libmamba` solver for Anaconda when creating the environment. It can speed up the process and avoid issues. You can find instructions for installing this solver here: https://www.anaconda.com/blog/a-faster-conda-for-a-growing-community

The `environment_unversioned.yml` file was created with `conda env export --from-history`. Creating a new environment from this file will use the most up-to-date dependencies.

Activate the environment:

```bash
conda activate fdc
```

There is a dependency version issue in the environment with QGIS and Python.  This can be fixed by symlinking the installed version of libgsl to the required one.

```bash
ln -s ${CONDA_PREFIX}/lib/libgsl.so.27  ${CONDA_PREFIX}/lib/libgsl.so.25
ln -s ${CONDA_PREFIX}/lib/libdraco.so.8  ${CONDA_PREFIX}/lib/libdraco.so.9
```

The repository also contains a `bin` directory with useful scripts.  The `format_sql.sh` script takes raw sqlite3 dumps and makes them more readable.

```bash
bin/format_sql.sh raw_dump.sql > sql/V00x__pretty_formatted.sql
```

### Running tests

To run the tests:

```bash
pytest -vvs test/
```

### Deploying plugin

To copy the plugin to your QGIS plugins folder, run:

```bash
bin/deploy_plugin.sh
```

You may need to manually activate the plugin if it was not installed already.

If you install the QGIS Plugin Reloader plugin, you can use it to quickly reload to the newly installed version.


### QGIS debugging tips

It is much easier to debug and understand your application by interacting with it directly.
This is possible in QGIS via the Python console.
Even better is the IPython QGIS console plugin, which offers tab complete.
It is necessary to have Jupyter installed on the Python environment used by QGIS in order to use it.
To access the plugin class within the Python console, run

```python
import qgis
fdc = qgis.utils.plugins['field_data_capture']
```

From there, plugin attributes and methods can accessed directly e.g. `fdc.add_gpkg_to_project()`


## Useful links

+ [PyQGIS Developer Cookbook](https://docs.qgis.org/3.28/en/docs/pyqgis_developer_cookbook/intro.html)
+ [QGIS Python API docs](https://qgis.org/pyqgis/3.28/)
+ [QGIS C++ API docs](https://api.qgis.org/api/3.28/)
+ [MerginMaps documentation](https://merginmaps.com/docs/layer/external-link/)
+ [SQLite docs (triggers)](https://sqlite.org/lang_createtrigger.html)
+ [GeoPackage getting started guide](http://www.geopackage.org/guidance/getting-started.html)
+ [GeoPackage data model guidance](https://www.geopackage.org/guidance/modeling.html)
+ [GeoPackage many-to-many](http://www.geopackage.org/guidance/extensions/related_tables.html)
