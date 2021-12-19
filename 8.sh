#!/bin/bash

FILE="8"
PROG="8"

echo -n "" > "${FILE}_guided.csv"
echo -n "" > "${FILE}_static.csv"
echo -n "" > "${FILE}_dynamic.csv"

echo  "size,1,2,4,8,16" >> "${FILE}_guided.csv"
echo  "size,1,2,4,8,16" >> "${FILE}_static.csv"
echo  "size,1,2,4,8,16" >> "${FILE}_dynamic.csv"

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
    echo "$LEN,$(echo $ONE_1 $ONE_2 $ONE_3 | awk '{print $1,$4,$7}'),$(echo $TWO_1 $TWO_2 $TWO_3 | awk '{print $1,$4,$7}'),$(echo $FOUR_1 $FOUR_2 $FOUR_3 | awk '{print $1,$4,$7}'),$(echo $EIGHT_1 $EIGHT_2 $EIGHT_3 | awk '{print $1,$4,$7}'),$(echo $SIXTEEN_1 $SIXTEEN_2 $SIXTEEN_3 | awk '{print $1,$4,$7}')" >> "${FILE}_static.csv"
    echo "$LEN,$(echo $ONE_1 $ONE_2 $ONE_3 | awk '{print $2,$5,$8}'),$(echo $TWO_1 $TWO_2 $TWO_3 | awk '{print $2,$5,$8}'),$(echo $FOUR_1 $FOUR_2 $FOUR_3 | awk '{print $2,$5,$8}'),$(echo $EIGHT_1 $EIGHT_2 $EIGHT_3 | awk '{print $2,$5,$8}'),$(echo $SIXTEEN_1 $SIXTEEN_2 $SIXTEEN_3 | awk '{print $2,$5,$8}')" >> "${FILE}_guided.csv"
    echo "$LEN,$(echo $ONE_1 $ONE_2 $ONE_3 | awk '{print $3,$6,$9}'),$(echo $TWO_1 $TWO_2 $TWO_3 | awk '{print $3,$6,$9}'),$(echo $FOUR_1 $FOUR_2 $FOUR_3 | awk '{print $3,$6,$9}'),$(echo $EIGHT_1 $EIGHT_2 $EIGHT_3 | awk '{print $3,$6,$9}'),$(echo $SIXTEEN_1 $SIXTEEN_2 $SIXTEEN_3 | awk '{print $3,$6,$9}')" >> "${FILE}_dynamic.csv"
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
