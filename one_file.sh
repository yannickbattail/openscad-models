#!/bin/bash

includes=$(cat "$1" | grep '^include' | sed -E 's/^include <([^>]*)>;?$/\1/' )
uses=$(    cat "$1" | grep '^use'     | sed -E 's/^use <([^>]*)>;?$/\1/' )
original_script_path=$(realpath $0)

echo "// ######################################################################################"
echo "// #  $1  #"
echo "// ######################################################################################"
#echo "$includes $uses" >&2
for file in $includes $uses
do
  pushd $(dirname $file) > /dev/null
  $original_script_path "$(basename $file)"
  popd > /dev/null
done
cat "$1" | grep -v '^include <' | grep -v '^use <'