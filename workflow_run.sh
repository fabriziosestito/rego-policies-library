#!/bin/bash

set -e

REPO_URL="https://github.com/kubewarden/rego-policies-library.git"
WORKFLOW="release_policy.yml"
OWNER="kubewarden"
REPO="policy-catalog"

# Get all tags
tags=$(git ls-remote --tags "$REPO_URL" | awk -F'refs/tags/' '{print $2}' | grep -v "\^{}" | grep -Ev "v0\.0\.1|v0\.1\.0" | sort -V)

echo "$tags"

if [ -z "$tags" ]; then
  echo "No tags found. Exiting."
  exit 1
fi

# Trigger workflow for each tag
for tag in $tags; do
  policy_name=$(echo "$tag" | awk -F'/' '{print $1}')
  echo "Triggering workflow run for policy: $policy_name"
  gh workflow run "$WORKFLOW" \
    --repo "$OWNER/$REPO" \
    --field owner="kubewarden" \
    --field repo="rego-policies-library" \
    --field tag="$tag" \
    --field artifacthub_pkg_path="policies/$policy_name/artifacthub-pkg.yml" \
    --field chart_dir="$policy_name"
done
