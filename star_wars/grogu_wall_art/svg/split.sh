#!/bin/bash

counter=0
mkdir -p splited_svg_path
echo > book.scad

cat all_path.svg | while read line 
do
  f="splited_svg_path/path_$counter.svg"
  cat start.svg > $f
  echo "$line" >> $f
  cat end.svg >> $f
  
  echo "import(\"$f\");" >> grogu.scad
  counter=$((counter+1))
#   echo $counter
done
