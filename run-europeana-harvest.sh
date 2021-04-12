#!/usr/bin/env sh
set -e
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
LOGFILE='europeana-harvest.log'
(	
	cd "${BASE_DIR}"
	echo "$(date) Starting preflight" | tee -a "$LOGFILE"
	./europeana-preflight.sh > 'assets/selection.xml' 2>> "$LOGFILE"
	echo "$(date) Starting harvest" | tee -a "$LOGFILE"
	./harvest.sh 'europeana-filtered' >> "$LOGFILE"
)


