#!/bin/bash

# Script to update repository URLs in all metadata.yml files under the policies folder
# Changes https://github.com/kubewarden/rego-policies to https://github.com/kubewarden/rego-policies-library

# Find all metadata.yml files in the policies directory
find staging -name "metadata.yml" -type f | while read -r file; do
    echo "Processing $file..."
    
    # Use sed to replace the URL in the file and save changes in place
    sed -i 's|https://github.com/kubewarden/rego-policies|https://github.com/kubewarden/rego-policies-library|g' "$file"
    
    # Verify the change was made
    if grep -q "https://github.com/kubewarden/rego-policies-library" "$file"; then
        echo "✓ Successfully updated $file"
    else
        echo "✗ Failed to update $file"
    fi
done

echo "URL update complete!"
