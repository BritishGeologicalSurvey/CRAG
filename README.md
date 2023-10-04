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

Create a virtual environment (Python 3.11) and install dependencies:

```bash
conda env create -f environment.yml
```

The `environment_unversioned.yml` file was created with `conda env export --from-history`. Creating a new environment from this file will use the most up-to-date dependencies.

The repository also contains a `bin` directory with useful scripts.  The `format_sql.sh` script takes raw sqlite3 dumps and makes them more readable.

```bash
bin/format_sql.sh raw_dump.sql > sql/V00x__pretty_formatted.sql
```

### Running tests

To run the tests:

```python
export PYTHONPATH=.
pytest -vvs test/
```

## Useful links

+ [PyQGIS Developer Cookbook](https://docs.qgis.org/3.28/en/docs/pyqgis_developer_cookbook/intro.html)
+ [QGIS Python API docs](https://qgis.org/pyqgis/3.28/)
+ [QGIS C++ API docs](https://api.qgis.org/api/3.28/)
+ [MerginMaps documentation](https://merginmaps.com/docs/layer/external-link/)
+ [SQLite docs (triggers)](https://sqlite.org/lang_createtrigger.html)
+ [GeoPackage getting started guide](http://www.geopackage.org/guidance/getting-started.html)
+ [GeoPackage data model guidance](https://www.geopackage.org/guidance/modeling.html)
+ [GeoPackage many-to-many](http://www.geopackage.org/guidance/extensions/related_tables.html)
