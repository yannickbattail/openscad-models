#!/bin/bash

export THINGIVERSE_TOKEN=$(npx openscad-generate@latest get-thingiverse-token)

npx openscad-generate@latest deploy-thingiverse --configFile lightsaber_holder.yaml ./lightsaber_holder.scad
