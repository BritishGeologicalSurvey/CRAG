#! /bin/bash

# Reformat the file with SQL Format, removing extra spaces.
cat $1 | sqlformat - --reindent --wrap_after 80 | sed -E 's/^\s+/  /g'
