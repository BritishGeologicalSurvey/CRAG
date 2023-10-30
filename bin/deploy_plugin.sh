#! /bin/bash

cd plugin
# -q does quick deployment, avoiding issues with HTML help pages.
pbt deploy -y -q --user-profile default
cd -