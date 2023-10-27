#!/bin/bash
tcc_run=$(<$HOME/files/hw1/task1_tcc_run_string.txt)
afl-fuzz -i $HOME/files/hw1/task1_afl_input/ -o $HOME/files/hw1/task1_afl_output/ $tcc_run
