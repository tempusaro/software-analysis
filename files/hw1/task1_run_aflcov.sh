#!/bin/bash
tcc_run=$(<task1_tcc_run_string.txt)
tcc_run=${tcc_run//\@\@/AFL_FILE}
tcc_run=${tcc_run//tcc-0.9.27/tcc-0.9.27\-cov}
$HOME/Desktop/hw1/afl-cov/afl-cov -d $HOME/Desktop/hw1/task1_afl_output/ --live --coverage-cmd "$HOME/Desktop/hw1/tcc-0.9.27-cov/tcc -I $HOME/Desktop/hw1/tcc-0.9.27-cov/include -o hello AFL_FILE" --code-dir $HOME/Desktop/hw1/tcc-0.9.27-cov/ --lcov-path /usr/local/bin/lcov --genhtml-path /usr/local/bin/genhtml
