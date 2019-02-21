#!/usr/bin/env bash
SCRIPT_DIR="/home/twagoo/test-harvest/europeana-oai-pmh"
FILTER_HARVEST="${SCRIPT_DIR}/filter-harvest.sh"
OUT_DIR_BASE="${SCRIPT_DIR}/out" #is fixed in script, not configurable here

if [ -d "$OUT_DIR_BASE" ]; then
	mv "${OUT_DIR_BASE}" "${OUT_DIR_BASE}-$(date +%Y%m%d%H%M%S)"
fi

filter_collections() {
  filter_collection "0940442_Ag_PL_bibliotekacyfrowa.eu" --open --media --fulltext
}

filter_collection() {
  COLLECTION="$1"
  shift
  bash "${FILTER_HARVEST}" --collection "${COLLECTION}" $@
}

gather() {
  find "${OUT_DIR_BASE}" -name selection.xml
}

filter_collections
gather
exit 0
