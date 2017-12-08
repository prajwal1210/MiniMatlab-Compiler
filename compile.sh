#! /bin/bash

make clean
make

file=$1

sfile=${file%%.*}

#echo $sfile

sfile=${sfile##*/}

#echo $sfile


./compiler.out  $sfile.c

#echo $sfile

cp $sfile.asm $sfile.s
gcc -c $sfile.s -o $sfile.o 
gcc -c  ass2_15CS30043.c -o ass2_15CS30043.o
gcc  $sfile.o ass2_15CS30043.o -o $sfile.out 
rm $sfile.o ass2_15CS30043.o
