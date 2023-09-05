# model-and-forms

> This repository contains code to add the field data capture layers to a QGIS project.

Scripts are required to:

+ Build a geopackage containing the field data capture data model
+ Run tests on the constraints, views and triggers within the data model
+ Add the field data capture layers to an open QGIS project
+ Configure forms within QGIS for the field data capture layers

The code in this repository should not depend on BGS infrastructure as it should be able to stand alone.


### Useful links

+ [PyQGIS Developer Cookbook](https://docs.qgis.org/3.28/en/docs/pyqgis_developer_cookbook/intro.html)
+ [QGIS Python API docs](https://qgis.org/pyqgis/3.28/)
+ [QGIS C++ API docs](https://api.qgis.org/api/3.28/)
+ [MerginMaps documentation](https://merginmaps.com/docs/layer/external-link/)
+ [SQLite docs (triggers)](https://sqlite.org/lang_createtrigger.html)
+ [GeoPackage getting started guide](http://www.geopackage.org/guidance/getting-started.html)
+ [GeoPackage data model guidance](https://www.geopackage.org/guidance/modeling.html)
+ [GeoPackage many-to-many](http://www.geopackage.org/guidance/extensions/related_tables.html)
