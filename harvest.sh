#!/usr/bin/env sh

SCRIPT_DIR=${PWD}
CONTAINER_NAME="oai-test-harvester"
HARVESTER_IMAGE="registry.gitlab.com/clarin-eric/docker-oai-harvester:1.1.0"
#HARVESTER_IMAGE="docker-oai-harvester:1.0.0-4-gbdefd2a"
RESOURCES_DIR="${SCRIPT_DIR}/resources"
ASSETS_DIR="${SCRIPT_DIR}/assets"
OUTPUT_DIR="${SCRIPT_DIR}/output"

if [ "$1" ]; then
	CONFIG_FILE="$1"
else
	echo "Usage: $0 <config file>" >&2
	exit 1
fi

if ! cp "${CONFIG_FILE}" "${RESOURCES_DIR}/config-test-test.xml"; then
	exit 1
fi


docker run \
	--rm --name ${CONTAINER_NAME} \
	-v ${OUTPUT_DIR}:/app/workdir \
	-v ${RESOURCES_DIR}:/app/oai/resources \
	-v ${ASSETS_DIR}:/app/oai/resources/assets \
        -v ${ASSETS_DIR}/expandMap.xsl:/app/oai/expandMap.xsl \
	${HARVESTER_IMAGE} -n test -o test

