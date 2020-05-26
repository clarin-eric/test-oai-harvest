#!/usr/bin/env sh

SCRIPT_DIR=${PWD}
CONFIG_INC_FILE="harvest-config.inc.sh"
CONFIG_INC_DEFAULT_FILE="harvest-config.inc.default.sh"

#load defaults
source "${SCRIPT_DIR}/${CONFIG_INC_DEFAULT_FILE}"
#load custom config
source "${SCRIPT_DIR}/${CONFIG_INC_FILE}"

if ! [ "${OUTPUT_BASE}" ]; then
	echo "Configuration variables not read. Make sure that the file(s) ${CONFIG_INC_FILE} and/or ${CONFIG_INC_DEFAULT_FILE} present in ${SCRIPT_DIR}"
	exit 1
fi

if [ "$1" ]; then
	CONFIG="$1"
	CONFIG_FILE="${CONFIG}.xml"
	OUTPUT_DIR="${OUTPUT_BASE}/${CONFIG}"
else
	echo "Usage: $0 <config>" >&2
	echo "There must be a file <config>.xml" >&2
	exit 1
fi

if ! cp "${CONFIG_FILE}" "${RESOURCES_DIR}/config-test-test.xml"; then
	exit 1
fi

mkdir -p "${OUTPUT_DIR}"

docker run \
	--rm --name ${CONTAINER_NAME} \
	-v ${OUTPUT_DIR}:/app/workdir \
	-v ${RESOURCES_DIR}:/app/oai/resources \
	-v ${ASSETS_DIR}:/app/oai/resources/assets \
        -v ${ASSETS_DIR}/expandMap.xsl:/app/oai/expandMap.xsl \
	${HARVESTER_IMAGE} -n test -o test

