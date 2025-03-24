#!/bin/bash
set -e

# Set the version string for tagging
VERSION="v1.0.0"

# Iterate over each directory in the policies folder
for policy in policies/*; do
  if [ -d "$policy" ]; then
    # Get the policy directory name
    policy_name=$(basename "$policy")
    # Construct the tag name
    tag="${policy_name}/${VERSION}"
    echo "Creating signed tag: ${tag}"
    # Create a signed annotated tag with the tag name as the message.
    git tag -s -a -m "$tag" $tag
    git push upstream $tag
    # git push --delete upstream $tag
    # git tag -d $tag
  fi
done

