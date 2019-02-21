#!/usr/bin/env bash
SCRIPT_DIR="/home/twagoo/test-harvest/europeana-oai-pmh"
FILTER_HARVEST="${SCRIPT_DIR}/filter-harvest.sh"
OUT_DIR_BASE="${SCRIPT_DIR}/out" #is fixed in script, not configurable here

if [ -d "$OUT_DIR_BASE" ]; then
	mv "${OUT_DIR_BASE}" "${OUT_DIR_BASE}-$(date +%Y%m%d%H%M%S)"
fi

filter_collections() {
  while read C; do filter_collection "$C" --open --media --fulltext; done <<EOF 
0940431_Ag_PL_rcin.org.pl
0940433_Ag_PL_mbc.malopolska.pl
15416_L_IE_IMC_oireachtas
2022410_Ag_RO_Elocal_documen1
9200394_Ag_Slovenia_Laibacher_Zeitung
9200452_UL_Old_Rare_Books_Lucian_Blaga
EOF

#  filter_collection "0940442_Ag_PL_bibliotekacyfrowa.eu" --open --media --fulltext
}

filter_collection() {
  COLLECTION="$1"
  shift
  bash "${FILTER_HARVEST}" --collection "${COLLECTION}" $@ > /dev/stderr
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

