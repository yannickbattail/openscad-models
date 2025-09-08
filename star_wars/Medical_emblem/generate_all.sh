#!/bin/bash

npx openscad-generate@latest generate --outFormats png,webp,3mf -p Medical_emblem3d --configFile Medical_emblem.yaml ./Medical_emblem.scad
npx openscad-generate@latest generate --outFormats png,pdf,svg  -p Medical_emblem2d --configFile Medical_emblem.yaml ./Medical_emblem.scad
