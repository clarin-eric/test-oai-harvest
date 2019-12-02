#!/usr/bin/env sh
set -e
LOGFILE=europeana-harvest.log
(	
	cd ~/test-harvest
	echo "$(date) Starting preflight" | tee -a $LOGFILE
	./europeana-preflight.sh > assets/selection.xml 2>> $LOGFILE
	echo "$(date) Starting harvest" | tee -a $LOGFILE
	./harvest.sh >> $LOGFILE
)


