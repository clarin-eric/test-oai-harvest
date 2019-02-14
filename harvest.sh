#!/usr/bin/env sh

SCRIPT_DIR=${PWD}
HARVESTER_IMAGE="registry.gitlab.com/clarin-eric/docker-oai-harvester:0.0.1-rc12"
RESOURCES_DIR="${SCRIPT_DIR}/resources"
OUTPUT_DIR="${SCRIPT_DIR}/output"

CONFIG_FILE="${SCRIPT_DIR}/config.xml"
cp "${CONFIG_FILE}" "${RESOURCES_DIR}/config-test-test.xml"


docker run \
	--rm --name oai-test-harvester \
	-v ${OUTPUT_DIR}:/app/workdir \
	-v ${RESOURCES_DIR}:/app/oai/resources \
	${HARVESTER_IMAGE} -n test -o test

