#!/bin/bash

set -e # Exit on error

parallelJobs=1
outFormats=png,webp,3mf

cd nutellaGlass ; npx openscad-generate@latest generate --outFormats ${outFormats} --mosaicFormat 3,3 --parallelJobs ${parallelJobs} --configFile ../globalConfig.yaml ./nutellaGlass.scad ; cd ..
cd mugC3po      ; npx openscad-generate@latest generate --outFormats ${outFormats} --mosaicFormat 2,1 --parallelJobs ${parallelJobs} --configFile ../globalConfig.yaml ./mugC3po.scad      ; cd ..
cd mugGrogu     ; npx openscad-generate@latest generate --outFormats ${outFormats} --mosaicFormat 2,1 --parallelJobs ${parallelJobs} --configFile ../globalConfig.yaml ./mugGrogu.scad     ; cd ..
cd mugTonneau   ; npx openscad-generate@latest generate --outFormats ${outFormats} --mosaicFormat 2,1 --parallelJobs ${parallelJobs} --configFile ../globalConfig.yaml ./mugTonneau.scad   ; cd ..
### it takes a loooong time (and cpu, and memory) to generate
cd mugImage     ; npx openscad-generate@latest generate --outFormats ${outFormats} --mosaicFormat 4,4 --parallelJobs ${parallelJobs} --configFile ../globalConfig.yaml ./mugImage.scad     ; cd ..
# not working (for now)
#cd mugR2d2      ; npx openscad-generate@latest generate --outFormats ${outFormats} --mosaicFormat 2,1 --parallelJobs ${parallelJobs} --configFile ../globalConfig.yaml ./mugR2d2.scad      ; cd ..
