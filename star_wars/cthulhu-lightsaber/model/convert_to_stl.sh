#!/bin/bash

# Check required OBJ files are present (single if, no loop)
if [ ! -f "manche.obj" ] || [ ! -f "partie1.obj" ] || [ ! -f "partie2.obj" ] || [ ! -f "partie3.obj" ]; then
  echo "you need to download the files manche.obj, partie1.obj, partie2.obj and partie3.obj here https://www.thingiverse.com/thing:5435250"
  exit 1
fi
npx openscad-generate@latest generate --parallelJobs 4 --configFile cthulhu-wand.yaml ./cthulhu-wand.scad
status=$?

if command -v notify-send >/dev/null 2>&1; then
  if [ $status -eq 0 ]; then
    notify-send -u normal "cthulhu-wand STL" "Conversion to STL finished successfully."
  else
    notify-send -u critical "cthulhu-wand STL" "Conversion to STL FAILED with exit code $status."
  fi
else
  if [ $status -eq 0 ]; then
    echo "[INFO] Conversion to STL finished successfully."
  else
    echo "[ERROR] Conversion to STL FAILED with exit code $status." >&2
  fi
fi

exit $status
