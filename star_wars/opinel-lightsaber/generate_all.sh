#!/bin/bash

npx openscad-generate@latest generate --outFormats png,webp,3mf --mosaicFormat 2,2 --configFile opinel-lightsaber.yaml ./opinel-lightsaber.scad

return_code=$?
if [ $return_code -ne 0 ]; then
  notify-send --urgency=normal --expire-time=5000 --app-name=openscad-generate --icon=openscad-nightly "Generation failed!" "Generation of opinel-lightsaber.scad failed with code $return_code"
  exit $return_code
else
  notify-send --urgency=low --expire-time=3000 --app-name=openscad-generate --icon=openscad-nightly "Generation complete!" "Generation of opinel-lightsaber.scad finished successful!"
fi
