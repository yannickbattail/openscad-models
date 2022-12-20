#!/bin/bash

one_file() {
    includes=$(grep '^include' "$1" | sed -E 's/^include <([^>]*)>;?$/\1/' )
    uses=$(    grep '^use'     "$1" | sed -E 's/^use <([^>]*)>;?$/\1/' )
    # echo "$includes $uses" >&2
    for file in $includes $uses
    do
      pushd "$(dirname "$file")" > /dev/null || exit 1 
      one_file "$(basename "$file")"
      popd > /dev/null || exit 1 
    done
    echo "// ######################################################################################"
    echo "// #  $1  #"
    echo "// ######################################################################################"
    grep -v '^include <' "$1" | grep -v '^use <'
}

one_file $1
