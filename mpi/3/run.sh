#!/bin/bash

FILE="3.csv"
PROG="main"

echo -n "" > $FILE

echo "size,2" >> $FILE

run () {
    TWO=$(FILE="slurm-$(sbatch -n 2 job.sh | cut -d ' ' -f 4).out"; while [ ! -f $FILE ]; do sleep 0.0001; done; while [ ! -s $FILE ]; do sleep 0.0001; done; cat $FILE);
    echo "$LEN,$TWO" >> $FILE
}

export LEN=100000
./compile.sh 3_${LEN}.cpp
run

export LEN=200000
./compile.sh 3_${LEN}.cpp
run

export LEN=400000
./compile.sh 3_${LEN}.cpp
run

export LEN=600000
./compile.sh 3_${LEN}.cpp
run

export LEN=800000
./compile.sh 3_${LEN}.cpp
run
