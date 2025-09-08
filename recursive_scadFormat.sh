#!/bin/bash

directory=$1

if [ -z "$directory" ]; then
  directory="."
fi

if [ ! -d "$directory" ]; then
  echo "Error: '$directory' is not a valid directory."
  exit 1
fi

find $directory -type f  -name "*.scad" -exec scadformat "{}" \;

find $directory -type f  -name "*.scadbak" -exec rm "{}" \;
