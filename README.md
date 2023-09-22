# model-and-forms plugin

> This repository contains code for a QGIS plugin to add the field data capture layers to a QGIS project and additional tools for using QGIS in the field.

Scripts are required to:

+ Build a geopackage containing the field data capture data model
+ Run tests on the constraints, views and triggers within the data model
+ Add the field data capture layers to an open QGIS project
+ Configure forms within QGIS for the field data capture layers
+ Configure QGIS to have minimal interface for ease of use on tablets

## Overall philosophy

The plugin in this repository should contain everything that is required to set up a field data capture project in QGIS.
There are a few overarching principles to bear in mind during development:

+ This is not an application, it is a GeoPackage and QGIS configuration optimised for geological field data capture.  The aim of the plugin is to automate the creation of the GeoPackage and Forms.
+ Once created, a project should function by itself, without requiring custom logic from the plugin.
+ At some point, this plugin is likely to be shared with overseas partners - it should not depend on BGS infrastructure nor on Mergin Maps and the liklihood of future translation requirements should be kept in mind.
+ If it is shared, it may be open sourced.  Code should be written in the assumption that the world will be able to see it.  No BGS infrastructure or credentials should be present.
+ Overseas partners may not have an internal data store for map creation.  The option to extend to inclusion of polygons for creation of a final map should be kept open.

## Running scripts

Create a virtual environment (Python 3.11) and install dependencies:

```bash
pip install -r requirements.txt
```

The `requirements.txt` file was created with [pip-compile](https://pip-tools.readthedocs.io/en/latest/cli/pip-compile/), which can be used again when dependencies need to be updated.

The repository also contains a `bin` directory with useful scripts.  The `format_sql.sh` script takes raw sqlite3 dumps and makes them more readable.

```bash
bin/format_sql.sh raw_dump.sql > sql/V00x__pretty_formatted.sql
```

## Running tests

Install `spatialite` extension for `sqlite`:

```bash
sudo apt install spatialite-bin libsqlite3-mod-spatialite
```

To run the tests:

```python
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
