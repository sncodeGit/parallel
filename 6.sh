#!/bin/bash

FILE="6.csv"
PROG="6"
VLEN="600"

echo -n "" > $FILE

echo "size,1,2,4,8,16" >> $FILE

run () {
    export OMP_NUM_THREADS=1
    ONE_1=$(echo $VLEN $LEN | ./$PROG)
    ONE_2=$(echo $VLEN $LEN | ./$PROG)
    ONE_3=$(echo $VLEN $LEN | ./$PROG)
    export OMP_NUM_THREADS=2
    TWO_1=$(echo $VLEN $LEN | ./$PROG)
    TWO_2=$(echo $VLEN $LEN | ./$PROG)
    TWO_3=$(echo $VLEN $LEN | ./$PROG)
    export OMP_NUM_THREADS=4
    FOUR_1=$(echo $VLEN $LEN | ./$PROG)
    FOUR_2=$(echo $VLEN $LEN | ./$PROG)
    FOUR_3=$(echo $VLEN $LEN | ./$PROG)
    export OMP_NUM_THREADS=8
    EIGHT_1=$(echo $VLEN $LEN | ./$PROG)
    EIGHT_2=$(echo $VLEN $LEN | ./$PROG)
    EIGHT_3=$(echo $VLEN $LEN | ./$PROG)
    export OMP_NUM_THREADS=16
    SIXTEEN_1=$(echo $VLEN $LEN | ./$PROG)
    SIXTEEN_2=$(echo $VLEN $LEN | ./$PROG)
    SIXTEEN_3=$(echo $VLEN $LEN | ./$PROG)
    echo "$LEN,$ONE_1 $ONE_2 $ONE_3,$TWO_1 $TWO_2 $TWO_3,$FOUR_1 $FOUR_2 $FOUR_3,$EIGHT_1 $EIGHT_2 $EIGHT_3,$SIXTEEN_1 $SIXTEEN_2 $SIXTEEN_3" >> $FILE
}

#
LEN=200
run

#
LEN=800
run
