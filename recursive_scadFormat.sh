#!/bin/bash

directory=$1
if [[] -z "$directory"]]
then
  directory="."
fi

find $directory -type f  -name "*.scad" -exec scadformat "{}" \;

find $directory -type f  -name "*.scadbak" -exec rm "{}" \;
