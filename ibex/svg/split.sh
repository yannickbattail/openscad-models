#!/bin/bash

counter=0
echo > book.scad

cat all_path.svg | while read line 
do
  f="svg/path_$counter.svg"
  cat start.svg > $f
  echo "$line" >> $f
  cat end.svg >> $f
  
  echo "import(\"$f\");" >> book.scad
  counter=$((counter+1))
#   echo $counter
done
