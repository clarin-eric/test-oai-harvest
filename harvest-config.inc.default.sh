#!/usr/bin/env sh

# Defaults for the harvester script. 
# DO NOT EDIT!
# Copy to a file named harvest-config.inc.sh and adapt to customise.

CONTAINER_NAME="oai-test-harvester"
HARVESTER_IMAGE="registry.gitlab.com/clarin-eric/docker-oai-harvester:1.1.0"
RESOURCES_DIR="${SCRIPT_DIR}/resources"
ASSETS_DIR="${SCRIPT_DIR}/assets"
OUTPUT_BASE="${SCRIPT_DIR}/output"

