#!/bin/bash

FILE="4.csv"
PROG="4"
A=1
B=2

# export OMP_SCHEDULE=static

echo -n "" > $FILE

echo "size,1,2,4,8,16" >> $FILE

run () {
    export OMP_NUM_THREADS=1
    ONE_1=$(echo $LEN $LEN | ./$PROG)
    ONE_2=$(echo $LEN $LEN | ./$PROG)
    ONE_3=$(echo $LEN $LEN | ./$PROG)
    export OMP_NUM_THREADS=2
    TWO_1=$(echo $LEN $LEN | ./$PROG)
    TWO_2=$(echo $LEN $LEN | ./$PROG)
    TWO_3=$(echo $LEN $LEN | ./$PROG)
    export OMP_NUM_THREADS=4
    FOUR_1=$(echo $LEN $LEN | ./$PROG)
    FOUR_2=$(echo $LEN $LEN | ./$PROG)
    FOUR_3=$(echo $LEN $LEN | ./$PROG)
    export OMP_NUM_THREADS=8
    EIGHT_1=$(echo $LEN $LEN | ./$PROG)
    EIGHT_2=$(echo $LEN $LEN | ./$PROG)
    EIGHT_3=$(echo $LEN $LEN | ./$PROG)
    export OMP_NUM_THREADS=16
    SIXTEEN_1=$(echo $LEN $LEN | ./$PROG)
    SIXTEEN_2=$(echo $LEN $LEN | ./$PROG)
    SIXTEEN_3=$(echo $LEN $LEN | ./$PROG)
    echo "$LEN,$ONE_1 $ONE_2 $ONE_3,$TWO_1 $TWO_2 $TWO_3,$FOUR_1 $FOUR_2 $FOUR_3,$EIGHT_1 $EIGHT_2 $EIGHT_3,$SIXTEEN_1 $SIXTEEN_2 $SIXTEEN_3" >> $FILE
}

#
LEN=4000
run

#
LEN=6000
run

#
LEN=8000
run

#
LEN=10000
run
