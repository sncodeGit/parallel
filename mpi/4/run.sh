#!/bin/bash

FILE="4.csv"
PROG="main"

echo -n "" > $FILE

echo "size,1,2,4,8,10,16,20,24,30,35,40,44" >> $FILE

run () {
    ONE=$(FILE="slurm-$(sbatch -n 1 job.sh | cut -d ' ' -f 4).out"; while [ ! -f $FILE ]; do sleep 0.0001; done; while [ ! -s $FILE ]; do sleep 0.0001; done; cat $FILE);
    TWO=$(FILE="slurm-$(sbatch -n 2 job.sh | cut -d ' ' -f 4).out"; while [ ! -f $FILE ]; do sleep 0.0001; done; while [ ! -s $FILE ]; do sleep 0.0001; done; cat $FILE);
    FOUR=$(FILE="slurm-$(sbatch -n 4 job.sh | cut -d ' ' -f 4).out"; while [ ! -f $FILE ]; do sleep 0.0001; done; while [ ! -s $FILE ]; do sleep 0.0001; done; cat $FILE);
    EIGHT=$(FILE="slurm-$(sbatch -n 8 job.sh | cut -d ' ' -f 4).out"; while [ ! -f $FILE ]; do sleep 0.0001; done; while [ ! -s $FILE ]; do sleep 0.0001; done; cat $FILE);
    TEN=$(FILE="slurm-$(sbatch -n 10 job.sh | cut -d ' ' -f 4).out"; while [ ! -f $FILE ]; do sleep 0.0001; done; while [ ! -s $FILE ]; do sleep 0.0001; done; cat $FILE);
    SEXTEEN=$(FILE="slurm-$(sbatch -n 16 job.sh | cut -d ' ' -f 4).out"; while [ ! -f $FILE ]; do sleep 0.0001; done; while [ ! -s $FILE ]; do sleep 0.0001; done; cat $FILE);
    TWENTY=$(FILE="slurm-$(sbatch -n 20 job.sh | cut -d ' ' -f 4).out"; while [ ! -f $FILE ]; do sleep 0.0001; done; while [ ! -s $FILE ]; do sleep 0.0001; done; cat $FILE);
    TWENTYFOUR=$(FILE="slurm-$(sbatch -n 24 job.sh | cut -d ' ' -f 4).out"; while [ ! -f $FILE ]; do sleep 0.0001; done; while [ ! -s $FILE ]; do sleep 0.0001; done; cat $FILE);
    THIRTY=$(FILE="slurm-$(sbatch -n 30 job.sh | cut -d ' ' -f 4).out"; while [ ! -f $FILE ]; do sleep 0.0001; done; while [ ! -s $FILE ]; do sleep 0.0001; done; cat $FILE);
    THIRTYFIVE=$(FILE="slurm-$(sbatch -n 35 job.sh | cut -d ' ' -f 4).out"; while [ ! -f $FILE ]; do sleep 0.0001; done; while [ ! -s $FILE ]; do sleep 0.0001; done; cat $FILE);
    FORTY=$(FILE="slurm-$(sbatch -n 40 job.sh | cut -d ' ' -f 4).out"; while [ ! -f $FILE ]; do sleep 0.0001; done; while [ ! -s $FILE ]; do sleep 0.0001; done; cat $FILE);
    FORTYFOUR=$(FILE="slurm-$(sbatch -n 44 job.sh | cut -d ' ' -f 4).out"; while [ ! -f $FILE ]; do sleep 0.0001; done; while [ ! -s $FILE ]; do sleep 0.0001; done; cat $FILE);
    echo "$LEN,$ONE,$TWO,$FOUR,$EIGHT,$TEN,$SEXTEEN,$TWENTY,$TWENTYFOUR,$THIRTY,$THIRTYFIVE,$FORTY,$FORTYFOUR" >> $FILE
}

export LEN=1000000
./compile.sh 4_${LEN}.cpp
run

export LEN=100000000
./compile.sh 4_${LEN}.cpp
run
