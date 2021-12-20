#!/bin/bash

FILE="5"
PROG="5"
A=1
B=2

echo -n "" > "${FILE}_critical.csv"
echo -n "" > "${FILE}_reduction.csv"
echo -n "" > "${FILE}_lock.csv"
echo -n "" > "${FILE}_atomic.csv"

echo  "size,1,2,4,8,16" >> "${FILE}_critical.csv"
echo  "size,1,2,4,8,16" >> "${FILE}_reduction.csv"
echo  "size,1,2,4,8,16" >> "${FILE}_lock.csv"
echo  "size,1,2,4,8,16" >> "${FILE}_atomic.csv"

run () {
    export OMP_NUM_THREADS=1
    ONE_1=$(echo $A $B $LEN | ./$PROG)
    ONE_2=$(echo $A $B $LEN | ./$PROG)
    ONE_3=$(echo $A $B $LEN | ./$PROG)
    export OMP_NUM_THREADS=2
    TWO_1=$(echo $A $B $LEN | ./$PROG)
    TWO_2=$(echo $A $B $LEN | ./$PROG)
    TWO_3=$(echo $A $B $LEN | ./$PROG)
    export OMP_NUM_THREADS=4
    FOUR_1=$(echo $A $B $LEN | ./$PROG)
    FOUR_2=$(echo $A $B $LEN | ./$PROG)
    FOUR_3=$(echo $A $B $LEN | ./$PROG)
    export OMP_NUM_THREADS=8
    EIGHT_1=$(echo $A $B $LEN | ./$PROG)
    EIGHT_2=$(echo $A $B $LEN | ./$PROG)
    EIGHT_3=$(echo $A $B $LEN | ./$PROG)
    export OMP_NUM_THREADS=16
    SIXTEEN_1=$(echo $A $B $LEN | ./$PROG)
    SIXTEEN_2=$(echo $A $B $LEN | ./$PROG)
    SIXTEEN_3=$(echo $A $B $LEN | ./$PROG)
    echo "$LEN,$(echo $ONE_1 $ONE_2 $ONE_3 | awk '{print $1,$5,$9}'),$(echo $TWO_1 $TWO_2 $TWO_3 | awk '{print $1,$5,$9}'),$(echo $FOUR_1 $FOUR_2 $FOUR_3 | awk '{print $1,$5,$9}'),$(echo $EIGHT_1 $EIGHT_2 $EIGHT_3 | awk '{print $1,$5,$9}'),$(echo $SIXTEEN_1 $SIXTEEN_2 $SIXTEEN_3 | awk '{print $1,$5,$9}')" >> "${FILE}_critical.csv"
    echo "$LEN,$(echo $ONE_1 $ONE_2 $ONE_3 | awk '{print $2,$6,$10}'),$(echo $TWO_1 $TWO_2 $TWO_3 | awk '{print $2,$6,$10}'),$(echo $FOUR_1 $FOUR_2 $FOUR_3 | awk '{print $2,$6,$10}'),$(echo $EIGHT_1 $EIGHT_2 $EIGHT_3 | awk '{print $2,$6,$10}'),$(echo $SIXTEEN_1 $SIXTEEN_2 $SIXTEEN_3 | awk '{print $2,$6,$10}')" >> "${FILE}_reduction.csv"
    echo "$LEN,$(echo $ONE_1 $ONE_2 $ONE_3 | awk '{print $3,$7,$11}'),$(echo $TWO_1 $TWO_2 $TWO_3 | awk '{print $3,$7,$11}'),$(echo $FOUR_1 $FOUR_2 $FOUR_3 | awk '{print $3,$7,$11}'),$(echo $EIGHT_1 $EIGHT_2 $EIGHT_3 | awk '{print $3,$7,$11}'),$(echo $SIXTEEN_1 $SIXTEEN_2 $SIXTEEN_3 | awk '{print $3,$7,$11}')" >> "${FILE}_lock.csv"
    echo "$LEN,$(echo $ONE_1 $ONE_2 $ONE_3 | awk '{print $4,$8,$12}'),$(echo $TWO_1 $TWO_2 $TWO_3 | awk '{print $4,$8,$12}'),$(echo $FOUR_1 $FOUR_2 $FOUR_3 | awk '{print $4,$8,$12}'),$(echo $EIGHT_1 $EIGHT_2 $EIGHT_3 | awk '{print $4,$8,$12}'),$(echo $SIXTEEN_1 $SIXTEEN_2 $SIXTEEN_3 | awk '{print $4,$8,$12}')" >> "${FILE}_atomic.csv"
}

#
LEN=10000
run

#
LEN=50000
run

#
LEN=100000
run

#
LEN=500000
run
