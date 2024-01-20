#!/bin/bash
tcc_run=$(<tcc_run_string.txt)
echo $tcc_run
tcc_run=${tcc_run//\@\@/AFL_FILE}
echo $tcc_run
tcc_run=${tcc_run//tcc/tcc\-cov}
echo $tcc_run
afl-cov -d /root/files/hw1/afl_output/ --live --coverage-cmd "/root/tcc-cov/bin/tcc -I /root/files/hw1/tcc-cov/include -o hello AFL_FILE" --code-dir /root/tinycc/ --lcov-path /usr/bin/lcov --genhtml-path /usr/bin/genhtml
