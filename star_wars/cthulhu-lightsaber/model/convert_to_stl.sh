#!/bin/bash

parallelJobs=4

# Check required OBJ files are present (single if, no loop)
if [ ! -f "manche.obj" ] || [ ! -f "partie1.obj" ] || [ ! -f "partie2.obj" ] || [ ! -f "partie3.obj" ]; then
  echo "you need to download the files manche.obj,  partie1.obj,  partie2.obj and partie3.obj here https://www.thingiverse.com/thing:5435250"
  exit 1
fi
npx openscad-generate@latest generate --outFormats binstl --parallelJobs $parallelJobs --configFile cthulhu-wand.yaml ./cthulhu-wand.scad
