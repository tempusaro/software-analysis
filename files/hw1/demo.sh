#!/bin/sh
set +e
set +x

(timeout 60s ./run_aflcov.sh) &
timeout 10s ./run_afl.sh
