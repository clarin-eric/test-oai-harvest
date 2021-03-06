#!/usr/bin/env bash
NAME="${1:-Europeana}"
OUTPUT_DIR="${PWD}/output"
watch -d -n 5 "find ${OUTPUT_DIR}/workdir/test-test/oai-pmh -type f|wc -l && find ${OUTPUT_DIR}/workdir/test-test/results/cmdi -type f|wc -l && tail -n 5 ${OUTPUT_DIR}/workdir/test-test/log/${NAME}.log && tree -ths ${OUTPUT_DIR}/workdir/test-test/results/cmdi | head -n 25"
