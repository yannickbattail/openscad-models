#!/bin/bash

export THINGIVERSE_TOKEN=$(npx openscad-generate@latest get-thingiverse-token)

npx openscad-generate@latest deploy-thingiverse --configFile etoile_et_foudre.yaml ./etoile_et_foudre.scad
