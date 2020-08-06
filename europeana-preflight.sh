#!/usr/bin/env bash
SCRIPT_DIR="/home/twagoo/test-harvest/europeana-oai-pmh"
FILTER_HARVEST="${SCRIPT_DIR}/filter-harvest.sh"
OUT_DIR_BASE="${SCRIPT_DIR}/out" #is fixed in script, not configurable here

if [ -d "$OUT_DIR_BASE" ]; then
	mv "${OUT_DIR_BASE}" "${OUT_DIR_BASE}-$(date +%Y%m%d%H%M%S)"
fi

filter_collections() {

	#added experimentally 2020-07-22
	while read C; do filter_collection "$C" --open --media --fulltext; done <<EOF 
205_FBC_WielkopolskaBibliotekaCyfrowa_Part1
222_Slovenia_Newspapers_Part1
EOF

}

filter_collection() {
  COLLECTION="$1"
  shift
  bash "${FILTER_HARVEST}" --collection "${COLLECTION}" $@ >&2
}

gather() {
  echo '<?xml version="1.0" encoding="UTF-8"?>'
  echo '<records>'

  find "${OUT_DIR_BASE}" -name selection.xml | xargs cat | egrep '^\s*<record.*</record>'

  echo '</records>'
}

filter_collections
gather
exit 0

