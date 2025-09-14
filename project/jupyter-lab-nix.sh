#!/usr/bin/env bash
set -e

# cd to the root directory
cd "$WORKSPACE_FOLDER"

# Run jupyter lab through nix-develop
./nix/tools/nix-develop.sh --command bash -c 'jupyter lab --no-browser'
