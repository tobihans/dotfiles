#!/usr/bin/env bash

set -euo pipefail

# This script is used to prune language package managers cache
# and the assets they produce.

# Node
npm cache clean --force
pnpm store prune
yarn cache clean
find ./Code -name "node_modules" -type d -prune -exec rm -rf '{}' +
find ./github -name "node_modules" -type d -prune -exec rm -rf '{}' +

# Python
pip cache purge
poetry cache clear --all -n PyPI
poetry cache clear --all -n _default_cache

# TODO: Add fr Cargo once I have a better understading of how it works

# Go
go clean -modcache

# System
yay -Sc
