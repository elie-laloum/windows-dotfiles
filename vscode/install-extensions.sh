#!/bin/bash

# Read the YAML file and extract extensions
extensions=$(yq e '.extensions[]' extensions.yaml)

# Install each extension
for extension in $extensions; do
    echo "Installing $extension..."
    code --install-extension $extension
done

echo "All extensions installed successfully!"