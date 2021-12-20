#!/bin/sh
#module add mpi/openmpi-local
module add openmpi
mpic++ $1 -o main