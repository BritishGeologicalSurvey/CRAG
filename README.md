<!--
Copyright 2026 British Geological Survey
Licensed under GPLv3 licence
SPDX-License-Identifier: GPL-3.0-or-later
-->
# model-and-forms plugin

> This repository contains code for a QGIS plugin to add the field data capture layers to a QGIS project and additional tools for using QGIS in the field.

Plugin documentation: http://field-data-capture.glpages.ad.nerc.ac.uk/sigma-q-user-guide/

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

- [Field Data Capture GPKG](https://kwvmxgit.ad.nerc.ac.uk/field-data-capture/model-and-forms/-/jobs/artifacts/main/raw/field-data-capture.gpkg?job=publish_artifacts)
- [Latest development build of plugin from `main` branch](https://kwvmxgit.ad.nerc.ac.uk/field-data-capture/model-and-forms/-/jobs/artifacts/main/raw/field_data_capture.zip?job=package_plugin)

### ER Diagram

There are 2 "primary key" columns on the data tables.  `fid` is used by QGIS/Geopackage.  We let the respective tool populate those and consider them unstable as the `fid` can change during Mergin Maps syncing process.  The `uuid` column is the unique key used to define parent-child relationships.

Note that all non-dictionary tables also have `recorded_by` and `recorded_on` columns.

- [Locality Diagram](https://kwvmxgit.ad.nerc.ac.uk/field-data-capture/model-and-forms/-/jobs/artifacts/main/raw/er-diagram-locality.png?job=publish_artifacts)
- [Lines Diagram](https://kwvmxgit.ad.nerc.ac.uk/field-data-capture/model-and-forms/-/jobs/artifacts/main/raw/er-diagram-lines.png?job=publish_artifacts)
- [Views Diagram](https://kwvmxgit.ad.nerc.ac.uk/field-data-capture/model-and-forms/-/jobs/artifacts/main/raw/er-diagram-views.png?job=publish_artifacts)

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

Activate the environment:

```bash
conda activate fdc
```

Some issues to do with `microarch-level` or `amd` package can be resolved by ensuring that the `archspec` package is available in the environment from which you are running `conda env create`.
This may require you to add it to the `base` environment and create the environment from there.

#### Dependency Issues

There are some dependency issues with the environment which can be fixed with the following:

> In previous environments, there have been issues with the library versions between QGIS and Python.
> For Python 3.12 and QGIS 3.40 this is not an issue.  If they arise in future, they
> can be fixed with a command with the following form.

```bash
ln -s ${CONDA_PREFIX}/lib/lib-version.so.1.2.3  ${CONDA_PREFIX}/lib/some-lib.so.1
```

> When building the wheels for `geodiff`, you may encounter a CMake error which can be fixed with the following solution: https://stackoverflow.com/questions/65485116/sqlite3-not-found-on-cmake

#### Add New Environment Dependency

When re-creating the environment with a new dependency, you should follow these steps:

- Add your new library to `environment_unversioned.yml`
- Delete your existing locality environment with: `conda remove -n fdc --all -y`
- Re-build your local environment with your change using: `conda env create -f environment_unversioned.yml -y`
- Activate the local environment: `conda activate fdc`
- Re-export your new local environment with: `conda env export > environment.yml`
- Remove any extra channels/prefix values from the updated `environment.yml`
- Add both environment files to git and commit them

There is an additional issue with building dependencies for the Docker container,
as libraries that we use in WSL may not have the same versions in the container OS.
For this reason, to update `environment_docker.yml` we have to build the unversioned
environment within the container and then get a shell within it to run the
export command. The following commands build, run and shell into a container.

```
docker build --target create-environment -t fdc .
docker run --name fdc_env --rm -it -d fdc
docker exec -it fdc_env /bin/bash
```

From within the container, acxtivate the environment, export the environment and then exit.

```
# conda activate fdc
# conda env export > environment_docker.yml
# exit
```

Copy out the updated environment file and stop it, it will be removed automatically.

```
docker cp fdc_env:environment_docker.yml .
docker stop fdc_env
```

### Bin Scripts

The repository also contains a `bin` directory with useful scripts. 

##### Format SQL

The `format_sql.sh` script takes raw sqlite3 dumps and makes them more readable.

```bash
bin/format_sql.sh raw_dump.sql > sql/V00x__pretty_formatted.sql
```

##### Mergin API

The `mergin_api.py` script takes a single string argument which it will use to search for projects in the `SIGMALite` namespace for deletion. It will ask for confirmation before deletion.

```bash
python bin/mergin_api.py conflict-test
```

##### Project Data Importer

The `project_data_importer.py` script takes 2 arguments which should both be filepaths to Field Data Capture project directories, it will then copy the first given project's data (source) into the second given project's data (destination). In the event of an error, the destination project will be restored from a backup handled by the script.

_Note: Both the source and destination project must be closed before attempting to import data._

```bash
python bin/project_data_importer.py my/fdc/project_src/ my/fdc_project/dest/
```

#### Running tests

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
