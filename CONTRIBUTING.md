# Contributing to CRAG

## Roadmap

`CRAG` is currently at release status.
All main features are complete, however contributions and suggestions are welcome.

See the [issues list](https://github.com/BritishGeologicalSurvey/crag/issues) for details of future development plans.

### Overall Philosophy

The plugin in this repository should contain everything that is required to set up a CRAG project in QGIS.
There are a few overarching principles to bear in mind during development:

+ This is not an application, it is a GeoPackage and QGIS configuration optimised for geological field data capture.  The aim of the plugin is to automate the creation of the GeoPackage and Forms.
+ Once created, a project should function by itself, without requiring custom logic from the plugin.
+ The plugin should not depend on BGS infrastructure nor on Mergin Maps and the likelihood of future translation requirements should be kept in mind.

## Developer setup

[https://www.github.com/BritishGeologicalSurvey/crag](https://www.github.com/BritishGeologicalSurvey/crag) is a the source-of-truth copy of CRAG.
Pull requests and issues should be targeted at this GitHub repository.

> The development environment is Linux under WSL, using a Conda virtual environment.

### Prerequisites

+ Python 3.12+ virtual environment
+ Git
+ QGIS


### Installation for development

Install OS system dependencies:

```bash
sudo apt install graphviz graphviz-dev build-essential spatialite-bin libsqlite3-mod-spatialite -y
```

 - spatialite provides access to spatial features that are used by some of the GeoPackage index triggers.
 - graphviz is used to generate the ER diagram.


Install locally for development by cloning repository and running the following
in the root:

```bash
conda env create -f environment.yml
```

It is beneficial to install the `libmamba` solver for Anaconda when creating the environment. It can speed up the process and avoid issues. You can find instructions for installing this solver here: https://www.anaconda.com/blog/a-faster-conda-for-a-growing-community

Activate the environment:

```bash
conda activate crag
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
- If the old environment is sctivated, deactivate: `conda deactivate`
- Delete your existing locality environment with: `conda remove -n crag --all -y`
- Re-build your local environment with your change using: `conda env create -f environment_unversioned.yml -y`
- Activate the local environment: `conda activate crag`
- Re-export your new local environment with: `conda env export > environment.yml`
- Remove any extra channels/prefix values from the updated `environment.yml`
- Add both environment files to git and commit them


### Bin Scripts

The repository also contains a `bin` directory with useful scripts. 

##### Format SQL

The `format_sql.sh` script takes raw sqlite3 dumps and makes them more readable.

```bash
bin/format_sql.sh raw_dump.sql > sql/V00x__pretty_formatted.sql
```


### Running tests

Automated tests are created using `pytest` and can be run with:

```bash
pytest -vv test/
```


### Deploying the plugin

To copy the plugin to your Linux QGIS plugins folder, run:

```bash
bin/deploy_plugin.sh
```

You may need to manually activate the plugin if it was not installed already.

If you install the QGIS Plugin Reloader plugin, you can use it to quickly reload to the newly installed version.

#### Manually deploying the plugin

If you are developing the plugin using Linux under WSL, but you need to test the plugin using QGIS under Windows,
you can manually copy the plugin to Windows. From within the repository folder and using your Windows username:

```bash
cp -rf CRAG /mnt/c/Users/windows_user/AppData/Roaming/QGIS/QGIS3/profiles/default/python/plugins/.
```


### QGIS debugging tips

It is much easier to debug and understand your application by interacting with it directly.
This is possible in QGIS via the Python console.
Even better is the IPython QGIS console plugin, which offers tab complete.
It is necessary to have Jupyter installed on the Python environment used by QGIS in order to use it.
To access the plugin class within the Python console, run:

```python
import qgis
crag = qgis.utils.plugins['crag']
```

From there, plugin attributes and methods can accessed directly e.g. `crag.add_gpkg_to_project()`


### Building documentation

The documentation is created using Sphinx.
To build the HTML documentation locally, run the following:
 
```bash
sphinx-build -M html docs/user_guide/source/ docs/user_guide/build/
```

The documentation can then be viewed at `docs/user_guide/build/html/index.html`


## Creating a new release

Releases are created manually from the main branch via tags.
This should be done via the GitHub web interface.
The GitHub Actions CI system will automatically run linting,
tests, security scans, and build the plugin for a new release.


## Useful links

+ [PyQGIS Developer Cookbook](https://docs.qgis.org/3.44/en/docs/pyqgis_developer_cookbook/intro.html)
+ [QGIS Python API docs](https://qgis.org/pyqgis/3.44/)
+ [QGIS C++ API docs](https://api.qgis.org/api/3.44/)
+ [MerginMaps documentation](https://merginmaps.com/docs/layer/external-link/)
+ [SQLite docs (triggers)](https://sqlite.org/lang_createtrigger.html)
+ [GeoPackage getting started guide](http://www.geopackage.org/guidance/getting-started.html)
+ [GeoPackage data model guidance](https://www.geopackage.org/guidance/modeling.html)
+ [GeoPackage many-to-many](http://www.geopackage.org/guidance/extensions/related_tables.html)
