#!/usr/bin/env bash
SCRIPT_DIR="/home/twagoo/test-harvest/europeana-oai-pmh"
FILTER_HARVEST="${SCRIPT_DIR}/filter-harvest.sh"
OUT_DIR_BASE="${SCRIPT_DIR}/out" #is fixed in script, not configurable here

if [ -d "$OUT_DIR_BASE" ]; then
	mv "${OUT_DIR_BASE}" "${OUT_DIR_BASE}-$(date +%Y%m%d%H%M%S)"
fi

filter_collections() {


	# added experimentally 2021Q1 (text + open)
	while read C; do filter_collection "$C" --open --media --text; done <<EOF
09311_Ag_EU_JHN_AllianceIsraelite_part2
284_Slovenia_ecc_Athena_plus
341_Hispana_FundacionGinerRios
386_ECC_NLSerbia_zenski_pokret
424_CY_today
294_Hispana_bvasturias
297_Hispana_minerva
303_Hispana_RODIN
308_Hispana_BVMalaga
09315_Ag_EU_JHN_GUF_jd
2021003_Ag_FI_NDL_fragmenta
2021716_Ag_CY_Gazettes
2021718_Ag_CY_Kiprologiko
0943102_Ag_BG_PenchoSlaveykov_ADVERT
0943101_Ag_BG_PenchoSlaveykov_ARTICLE
EOF

	# added experimentally 2021Q1 (text, confirmed acceptable conditions)
	while read C; do filter_collection "$C" --media --text; done <<EOF
394_DRI_IQDA_2
EOF

# Media collections

filter_collection 217_UCC_DRI --sound
filter_collection 204_DRI_MonaghanCC --video

#added 2020Q1
filter_collection 15416_L_IE_IMC_oireachtas --media --text --open
filter_collection 100_RoL_NLScotland_RareBooksDigitalGallery_iiif --media --text --open
filter_collection 101_RoL_NLWales_Almancs --media --text --open
filter_collection 102_RoL_NLWales_Dictionaries --media --text --open
filter_collection 103_RoL_NLWales_KeyTexts --media --text --open
filter_collection 104_RoL_NLWales_Manuscripts --media --text --open
filter_collection 28_RoL_NLSerbia_periodika_psr --media --text --open
filter_collection 29_RoL_NLSerbia_evropa --media --text --open
filter_collection 32_RoL_NLSerbia_avangarde --media --text --open
filter_collection 33_RoL_NLSerbia_putopisi --media --text --open
filter_collection 34_RoL_NLSerbia_vk --media --text --open
filter_collection 35_RoL_NLSerbia_moderna --media --text --open
filter_collection 36_RoL_NLSerbia_stampana --media --text
filter_collection 37_RoL_NLSerbia_beleske --media --text --open
filter_collection 39_RoL_CulturaItalia_cnr_ovi --media --text
filter_collection 50_KB_RiseOfLiteracy_Kinderboeken --media --text --open
filter_collection 54_mig_jev_periodika_Serbia --media --text --open
filter_collection 60_mig_romi_knjige_Serbia --media --text --open
filter_collection 92_RoL_NULSlovenia_newspapers --media --text --open

while read C; do filter_collection "$C" --open --media --fulltext; done <<EOF 
106_RoL_NLScotland_EarlyGaelicBooks
150_Ag_EU_JHN_AllianceIsraelite_part1
2021624_Ag_NL_DigitaleCollectie_atria
6_RoL_NLLatvia_Collection57760
94_RoL_NLLatvia_Collection_569516
97_RoL_NLLatvia_Collection_748774
0940429_Ag_PL_www.bibliotekacyfrowa.pl
0940442_Ag_PL_bibliotekacyfrowa.eu
EOF

filter_collection 9200114_Ag_EU_TEL_a0516_Bulgaria_Manuscript --media --text
filter_collection 2022411_Ag_RO_Elocal_audioinb
filter_collection 2022402_Ag_RO_Elocal_arhivele

filter_collection 92078_Ag_EU_TEL_a1030_EuropanaRegia --text --open
#filter_collection 92004_NL_Manuscriptorium_CZ
#filter_collection 9200519_Ag_BnF_Gallica_typedoc_manuscrits --text
#filter_collection 92065_Ag_EU_TEL_a0445_ETravel --media --text --open

#added 2020-07-22
while read C; do filter_collection "$C" --open --media --fulltext; done <<EOF 
205_FBC_WielkopolskaBibliotekaCyfrowa_Part1
222_Slovenia_Newspapers_Part1
9200394_Slovenia_Laibacher_Zeitung
223_Slovenia_Slovenski_gospodar_Ljubljanski_zvon
194_Slovenia_Kmetijske_in_rokodelske_novice
15_Slovenia_Newspapers_Part3
221_Slovenia_Newspapers_Part4
2020128_Slovenia_Newspapers_Part2
0943108_Ag_BG_PenchoSlaveykov_LIBVAR_ARTICLE_2014
0943110_Ag_BG_PenchoSlaveykov_LIBVAR_ARTICLE_2015
0943109_Ag_BG_PenchoSlaveykov_LIBVAR_ADVERT_2014
0943111_Ag_BG_PenchoSlaveykov_LIBVAR_ADVERT_2015
92068_Slovenia_Europeana_travel
2020127_Slovenia_Books
EOF

#added earlier
while read C; do filter_collection "$C" --open --media --fulltext; done <<EOF 
0940431_Ag_PL_rcin.org.pl
0940433_Ag_PL_mbc.malopolska.pl
2022410_Ag_RO_Elocal_documen1
9200452_UL_Old_Rare_Books_Lucian_Blaga
9200453_UL_Manuscripts_Lucian_Blaga
9200456_UL_Reprints_Lucian_Blaga
9200467_Ag_TEL_a1188_eCloud_Debrecen
9200470_UL_Periodicals_Lucian_Blaga
9200498_Ag_BnF_occitanica
EOF
#  filter_collection "0940442_Ag_PL_bibliotekacyfrowa.eu" --open --media --fulltext


while read C; do filter_collection "$C" --open --media --text; done <<EOF 
0940423_FBC_WielkopolskaBibliotekaCyfrowa_Part2
EOF

#confirmed acceptable conditions
       while read C; do filter_collection "$C" --media --text; done <<EOF
129_RoL_OVI_manoscritti
113_RoL_CulturaItalia_cnr_ovi_plutei
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

