#!/bin/bash
tcc_run=$(<task1_tcc_run_string.txt)
$HOME/Desktop/hw1/afl-2.52b/afl-fuzz -i $HOME/Desktop/hw1/task1_afl_input/ -o $HOME/Desktop/hw1/task1_afl_output/ $tcc_run
