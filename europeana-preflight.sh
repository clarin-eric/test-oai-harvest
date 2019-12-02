#!/usr/bin/env bash
SCRIPT_DIR="/home/twagoo/test-harvest/europeana-oai-pmh"
FILTER_HARVEST="${SCRIPT_DIR}/filter-harvest.sh"
OUT_DIR_BASE="${SCRIPT_DIR}/out" #is fixed in script, not configurable here

if [ -d "$OUT_DIR_BASE" ]; then
	mv "${OUT_DIR_BASE}" "${OUT_DIR_BASE}-$(date +%Y%m%d%H%M%S)"
fi

filter_collections() {
	filter_collection 9200114_Ag_EU_TEL_a0516_Bulgaria_Manuscript --media --text
	filter_collection 92068_Ag_Slovenia_ETravel --media --text --open
	filter_collection 2022411_Ag_RO_Elocal_audioinb
	filter_collection 2022402_Ag_RO_Elocal_arhivele

	filter_collection 0940429_Ag_PL_www.bibliotekacyfrowa.pl --media --text --open
	filter_collection 2020125_Ag_SI_Nat.EContentAgg_sigic_articles --media --fulltext --open 
	filter_collection 2020127_Ag_SI_Nat.EContentAgg_Books --media --fulltext --open
	filter_collection 0940442_Ag_PL_bibliotekacyfrowa.eu --media --fulltext --open
	filter_collection 92078_Ag_EU_TEL_a1030_EuropanaRegia --text --open
	#filter_collection 92004_NL_Manuscriptorium_CZ
	#filter_collection 9200519_Ag_BnF_Gallica_typedoc_manuscrits --text
	#filter_collection 92065_Ag_EU_TEL_a0445_ETravel --media --text --open

  while read C; do filter_collection "$C" --open --media --fulltext; done <<EOF 
0940431_Ag_PL_rcin.org.pl
0940433_Ag_PL_mbc.malopolska.pl
15416_L_IE_IMC_oireachtas
2022410_Ag_RO_Elocal_documen1
9200394_Ag_Slovenia_Laibacher_Zeitung
9200452_UL_Old_Rare_Books_Lucian_Blaga
9200453_UL_Manuscripts_Lucian_Blaga
9200456_UL_Reprints_Lucian_Blaga
9200467_Ag_TEL_a1188_eCloud_Debrecen
9200470_UL_Periodicals_Lucian_Blaga
9200498_Ag_BnF_occitanica
92054_Ag_Slovenia_Dom_in_svet
92055_Ag_Slovenia_Ljubljanski_zvon
EOF

#  filter_collection "0940442_Ag_PL_bibliotekacyfrowa.eu" --open --media --fulltext
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

