#!/usr/bin/env bash

DATAROOTS_DIR="/home/deploy/vlo/dataroots/test-mount"
DATAROOTS_FILE="/home/deploy/vlo/dataroots/testing-dataroots.xml"

set -e
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
SET_NAME="$1"

if ! [[ "${SET_NAME}" ]]; then
	echo "Usage: $0 <set-name>"
	exit 1
fi

SRC_DIR="${BASE_DIR}/output/${SET_NAME}/output/test"
if ! [ -d "${SRC_DIR}" ]; then
	echo "Fatal: ${SRC_DIR}/results not found"
	exit 1
fi

TARGET_DIR="${DATAROOTS_DIR}/${SET_NAME}"
if [ -d "${TARGET_DIR}/results" ]; then
	BACKUP_PARENT_DIR="${TARGET_DIR}/old"
	mkdir -p "${BACKUP_PARENT_DIR}"
	BACKUP_DIR="${BACKUP_PARENT_DIR}/results-$(date +"%Y%m%d_%H_%M_%S")"
	echo "Moving existing target directory out of the way to ${BACKUP_DIR}"
	mv "${TARGET_DIR}/results" "${BACKUP_DIR}"
fi

if ! mkdir -p "${TARGET_DIR}"; then
	echo "Fatal: could not make or use target directory ${TARGET_DIR}"
	exit 1
fi

echo "Copying contents of ${SRC_DIR} to ${TARGET_DIR}"
cp -r "${SRC_DIR}/results" "${TARGET_DIR}"

echo "Done"

echo "You can now add the following to ${DATAROOTS_FILE}:"

echo "
   <DataRoot>
        <originName>${SET_NAME}</originName>
        <rootFile>/srv/vlo-data/test/${SET_NAME}/results/cmdi/</rootFile>
        <prefix>http://alpha-vlo.clarin.eu/data/</prefix>
        <tostrip>/srv/vlo-data/</tostrip>
        <deleteFirst>true</deleteFirst>
   </DataRoot>"
