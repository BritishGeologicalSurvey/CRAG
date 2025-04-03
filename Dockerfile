FROM continuumio/miniconda3:25.1.1-2

# Install operating system dependencies
RUN apt-get update -y \
    && apt-get install -y \
      build-essential \
      # graphviz is required to render ER diagrams
      graphviz \
      graphviz-dev \
      # spatialite provides spatial functions in SQLite database
      spatialite-bin \
      libsqlite3-mod-spatialite \
      # xvfb provides a headless X server for testing gui apps
      xvfb \
      zip \
      # libsqlite3 is required to build pygeodiff
      libsqlite3-dev \
    && apt-get clean

RUN conda config --set solver libmamba

# This section is used to generate an environment.yml that is
# suitable for use in the container.  One from the WSL or Windows
# environment is not compatible.  Once created, start the container
# to extract the environment settings.
#COPY environment_unversioned.yml /environment_unversioned.yml
#RUN conda env create -f /environment_unversioned.yml

COPY environment_docker.yml /environment_docker.yml
RUN conda env create -f /environment_docker.yml


