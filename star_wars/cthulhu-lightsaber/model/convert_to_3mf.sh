#!/bin/bash

# Check required OBJ files are present (single if, no loop)
if [ ! -f "cthulhu-wand_manche_fixed.stl" ] || [ ! -f "cthulhu-wand_partie1_fixed.stl" ] || [ ! -f "cthulhu-wand_partie2_fixed.stl" ] || [ ! -f "cthulhu-wand_partie3_fixed.stl" ]; then
  echo "you need to repair the cthulhu-wand_manche.stl, cthulhu-wand_partie1.stl, cthulhu-wand_partie2.stl and cthulhu-wand_partie3.stl here https://www.formware.co/onlinestlrepair and put the files in this dir with the ending in _fixed.stl"
  exit 1
fi

npx openscad-generate@latest generate --parallelJobs 5 --configFile cthulhu-wand_3mf.yaml ./cthulhu-wand_3mf.scad
status=$?

if command -v notify-send >/dev/null 2>&1; then
  if [ $status -eq 0 ]; then
    notify-send -u normal "cthulhu-wand 3mf" "Conversion to 3MF finished successfully."
  else
    notify-send -u critical "cthulhu-wand 3mf" "Conversion to 3MF FAILED with exit code $status."
  fi
else
  if [ $status -eq 0 ]; then
    echo "[INFO] Conversion to 3MF finished successfully."
  else
    echo "[ERROR] Conversion to 3MF FAILED with exit code $status." >&2
  fi
fi

exit $status
