#!/bin/bash

parallelJobs=4
outFormats=png,webp,3mf

npx openscad-generate@latest generate --outFormats ${outFormats} --mosaicFormat 2,2 --parallelJobs ${parallelJobs} --configFile globalConfig.yaml ./nutellaGlass.scad
npx openscad-generate@latest generate --outFormats ${outFormats} --mosaicFormat 2,1 --parallelJobs ${parallelJobs} --configFile globalConfig.yaml ./mugC3po.scad
npx openscad-generate@latest generate --outFormats ${outFormats} --mosaicFormat 2,1 --parallelJobs ${parallelJobs} --configFile globalConfig.yaml ./mugGrogu.scad
npx openscad-generate@latest generate --outFormats ${outFormats} --mosaicFormat 2,1 --parallelJobs ${parallelJobs} --configFile globalConfig.yaml ./mugTonneau.scad
### it takes a loooong time (and cpu, and memory) to generate
npx openscad-generate@latest generate --outFormats ${outFormats} --mosaicFormat 4,3 --parallelJobs ${parallelJobs} --configFile globalConfig.yaml ./mugImage.scad
# not working (for now)
## npx openscad-generate@latest generate --outFormats ${outFormats} --mosaicFormat 2,1 --parallelJobs ${parallelJobs} --configFile globalConfig.yaml ./mugR2d2.scad
