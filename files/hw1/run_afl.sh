#!/bin/bash
tcc_run=$(<$HOME/files/hw1/tcc_run_string.txt)
afl-fuzz -i $HOME/files/hw1/afl_input/ -o $HOME/files/hw1/afl_output/ $tcc_run
