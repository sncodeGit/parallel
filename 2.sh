#!/bin/bash

FILE="2.csv"
PROG="2"

echo -n "" > $FILE

echo "size,1,2,4,8,16" >> $FILE

run () {
    export OMP_NUM_THREADS=1
    ONE_1=$(echo $LEN | ./$PROG)
    ONE_2=$(echo $LEN | ./$PROG)
    ONE_3=$(echo $LEN | ./$PROG)
    export OMP_NUM_THREADS=2
    TWO_1=$(echo $LEN | ./$PROG)
    TWO_2=$(echo $LEN | ./$PROG)
    TWO_3=$(echo $LEN | ./$PROG)
    export OMP_NUM_THREADS=4
    FOUR_1=$(echo $LEN | ./$PROG)
    FOUR_2=$(echo $LEN | ./$PROG)
    FOUR_3=$(echo $LEN | ./$PROG)
    export OMP_NUM_THREADS=8
    EIGHT_1=$(echo $LEN | ./$PROG)
    EIGHT_2=$(echo $LEN | ./$PROG)
    EIGHT_3=$(echo $LEN | ./$PROG)
    export OMP_NUM_THREADS=16
    SIXTEEN_1=$(echo $LEN | ./$PROG)
    SIXTEEN_2=$(echo $LEN | ./$PROG)
    SIXTEEN_3=$(echo $LEN | ./$PROG)
    echo "$LEN,$ONE_1 $ONE_2 $ONE_3,$TWO_1 $TWO_2 $TWO_3,$FOUR_1 $FOUR_2 $FOUR_3,$EIGHT_1 $EIGHT_2 $EIGHT_3,$SIXTEEN_1 $SIXTEEN_2 $SIXTEEN_3" >> $FILE
}

#
LEN=100000
run

#
LEN=1000000
run

#
LEN=10000000
run

#
LEN=100000000
run
