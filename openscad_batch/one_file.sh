#!/bin/bash

includes=$(grep '^include' "$1" | sed -E 's/^include <([^>]*)>;?$/\1/' )
uses=$(    grep '^use' "$1"     | sed -E 's/^use <([^>]*)>;?$/\1/' )
original_script_path=$(realpath "$0")

echo "// ######################################################################################"
echo "// #  $1  #"
echo "// ######################################################################################"
#echo "$includes $uses" >&2
for file in $includes $uses
do
  pushd "$(dirname "$file")" > /dev/null || exit 1 
  $original_script_path "$(basename "$file")"
  popd > /dev/null || exit 1 
done
grep -v '^include <' "$1" | grep -v '^use <'
