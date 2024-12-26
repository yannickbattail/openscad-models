#!/bin/bash

inFile=$1
outDir=split_svg_path
outFile=$(basename $inFile .svg).scad
mkdir -p $outDir
echo > $outFile

head -n 2 $inFile > $outDir/start.svg
tail -n 1 $inFile > $outDir/end.svg

counter=0
fileNum=0
cat $inFile | while read line
do
  echo -n " $counter"
  if [[ "$line" != "<?xml"* ]] && [[ "$line" != "<svg"* ]] && [[ "$line" != "</svg>" ]] ; then
    f="$outDir/path_$fileNum.svg"
    cat $outDir/start.svg > $f
    echo "$line" >> $f
    cat $outDir/end.svg >> $f
    echo "import(\"$f\");" >> $outFile
    echo -n "#"
    fileNum=$((fileNum+1))
  fi
  counter=$((counter+1))
done
echo
echo "Done."
