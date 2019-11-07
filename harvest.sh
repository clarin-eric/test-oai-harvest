#!/usr/bin/env sh

SCRIPT_DIR=${PWD}
CONTAINER_NAME="oai-test-harvester"
HARVESTER_IMAGE="registry.gitlab.com/clarin-eric/docker-oai-harvester:0.0.1-rc12"
RESOURCES_DIR="${SCRIPT_DIR}/resources"
ASSETS_DIR="${SCRIPT_DIR}/assets"
OUTPUT_DIR="${SCRIPT_DIR}/output"

if [ "$1" ]; then
	CONFIG_FILE="$1"
else
	CONFIG_FILE="${SCRIPT_DIR}/config.xml"
fi
cp "${CONFIG_FILE}" "${RESOURCES_DIR}/config-test-test.xml"


docker run \
	--rm --name ${CONTAINER_NAME} \
	-v ${OUTPUT_DIR}:/app/workdir \
	-v ${RESOURCES_DIR}:/app/oai/resources \
	-v ${ASSETS_DIR}:/app/oai/resources/assets \
	${HARVESTER_IMAGE} -n test -o test

