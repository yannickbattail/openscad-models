#!/bin/bash

export THINGIVERSE_TOKEN=$(npx openscad-generate@latest get-thingiverse-token)

npx openscad-generate@latest deploy-thingiverse --configFile animal_d20.yaml ./animal_d20.scad
