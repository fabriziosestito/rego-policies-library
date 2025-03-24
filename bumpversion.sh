#!/bin/bash
set -e

# Iterate over each directory in the policies folder.
for policy in staging/*; do
  if [ -d "$policy" ]; then
    echo "Processing policy: $policy"
    # Change into the policy directory, run the Makefile target with the version parameter.
    (cd "$policy" && rm -f artifacthub-pkg.yml && make VERSION=0.1.0 artifacthub-pkg.yml)
  fi
done
