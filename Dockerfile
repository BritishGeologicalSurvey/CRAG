FROM continuumio/miniconda3:25.11.1-1@sha256:0be0ff1d9cedadcfe67e05ae2097e02e31d267fe1cb766e81a77eead67e8e4c5

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

# These commands are required to build containers on the VPN
# The VPN changes the certificate chain so we need to recognise
# the local certificates.
COPY certs/*.crt /usr/local/share/ca-certificates
RUN update-ca-certificates
ENV REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt

# This section is used to generate an environment.yml that is
# suitable for use in the container.  One from the WSL or Windows
# environment is not compatible.  Once created, start the container
# to extract the environment settings.
#COPY environment_unversioned.yml /environment_unversioned.yml
#RUN conda env create -f /environment_unversioned.yml

ENV PIP_INDEX_URL=https://nexus-internal.bgs.ac.uk/repository/pypi-all/simple
ENV CONDA_OVERRIDE_ARCHSPEC=x86_64_v4
COPY environment_docker.yml /environment_docker.yml
RUN conda env create -f /environment_docker.yml
