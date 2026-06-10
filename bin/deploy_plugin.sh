#! /bin/bash

cd CRAG
# -q does quick deployment, avoiding issues with HTML help pages.
# UPDATE: -q does not delete the existing plugin files, which means deleted files are not removed
pbt deploy -y --user-profile default
cd -