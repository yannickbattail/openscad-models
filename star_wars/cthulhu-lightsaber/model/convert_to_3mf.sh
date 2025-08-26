#!/bin/bash

parallelJobs=4

# Check required OBJ files are present (single if, no loop)
if [ ! -f "cthulhu-wand_manche_fixed.stl" ] || [ ! -f "cthulhu-wand_partie1_fixed.stl" ] || [ ! -f "cthulhu-wand_partie2_fixed.stl" ] || [ ! -f "cthulhu-wand_partie3_fixed.stl" ]; then
  echo "you need to repair the cthulhu-wand_manche.stl, cthulhu-wand_partie1.stl, cthulhu-wand_partie2.stl and cthulhu-wand_partie3.stl here https://www.formware.co/onlinestlrepair and put the files in this dir with the ending in _fixed.stl"
  exit 1
fi

npx openscad-generate@latest generate --outFormats 3mf --parallelJobs $parallelJobs --configFile cthulhu-wand.yaml ./cthulhu-wand_3mf.scad
