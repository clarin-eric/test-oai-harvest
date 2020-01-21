#!/usr/bin/env bash
SCRIPT_DIR="/home/twagoo/test-harvest/europeana-oai-pmh"
FILTER_HARVEST="${SCRIPT_DIR}/filter-harvest.sh"
OUT_DIR_BASE="${SCRIPT_DIR}/out" #is fixed in script, not configurable here

if [ -d "$OUT_DIR_BASE" ]; then
	mv "${OUT_DIR_BASE}" "${OUT_DIR_BASE}-$(date +%Y%m%d%H%M%S)"
fi

filter_collections() {

	#added experimentally 2020-01-21
	filter_collection 100_RoL_NLScotland_RareBooksDigitalGallery_iiif --media --text --open
	filter_collection 101_RoL_NLWales_Almancs --media --text --open
	filter_collection 102_RoL_NLWales_Dictionaries --media --text --open
	filter_collection 103_RoL_NLWales_KeyTexts --media --text --open
	filter_collection 104_RoL_NLWales_Manuscripts --media --text --open
	filter_collection 150_Ag_EU_JHN_AllianceIsraelite_part1 --media --fulltext --open
	filter_collection 2020126_Ag_SI_NatEContentAgg_newspaperspart1 --media --text --open
	filter_collection 2020128_Ag_SI_Nat_EContentAgg_newspapers_part2 --media --text --open
	filter_collection 28_RoL_NLSerbia_periodika_psr --media --text --open
	filter_collection 29_RoL_NLSerbia_evropa --media --text --open
	filter_collection 32_RoL_NLSerbia_avangarde --media --text --open
	filter_collection 33_RoL_NLSerbia_putopisi --media --text --open
	filter_collection 34_RoL_NLSerbia_vk --media --text --open
	filter_collection 35_RoL_NLSerbia_moderna --media --text --open
	filter_collection 36_RoL_NLSerbia_stampana --media --text
	filter_collection 37_RoL_NLSerbia_beleske --media --text --open
	filter_collection 38_NULSlovenia_ivan_letters --media --text
	filter_collection 39_RoL_CulturaItalia_cnr_ovi --media --text
	filter_collection 50_KB_RiseOfLiteracy_Kinderboeken --media --text --open
	filter_collection 54_mig_jev_periodika_Serbia --media --text --open
	filter_collection 60_mig_romi_knjige_Serbia --media --text --open
	filter_collection 92_RoL_NULSlovenia_newspapers --media --text --open

while read C; do filter_collection "$C" --open --media --fulltext; done <<EOF 
106_RoL_NLScotland_EarlyGaelicBooks
150_Ag_EU_JHN_AllianceIsraelite_part1
15_RoL_NUL_Slovenia_Newspapers_part_3
2020127_Ag_SI_NatEContentAgg_Books
2021624_Ag_NL_DigitaleCollectie_atria
6_RoL_NLLatvia_Collection57760
94_RoL_NLLatvia_Collection_569516
97_RoL_NLLatvia_Collection_748774
0940429_Ag_PL_www.bibliotekacyfrowa.pl
0940442_Ag_PL_bibliotekacyfrowa.eu
EOF

	filter_collection 9200114_Ag_EU_TEL_a0516_Bulgaria_Manuscript --media --text
	filter_collection 92068_Ag_Slovenia_ETravel --media --text --open
	filter_collection 2022411_Ag_RO_Elocal_audioinb
	filter_collection 2022402_Ag_RO_Elocal_arhivele

	filter_collection 2020125_Ag_SI_Nat.EContentAgg_sigic_articles --media --fulltext --open 
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

