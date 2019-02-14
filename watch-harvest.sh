#!/usr/bin/env bash
NAME="${1:-Europeana}"
watch -d -n 5 "find output/workdir/test-test/oai-pmh -type f|wc -l && find output/workdir/test-test/results -type f|wc -l && tail -n 5 output/workdir/test-test/log/${NAME}.log && ls -lh output/workdir/test-test/oai-pmh/${NAME} | tail -n 10"
