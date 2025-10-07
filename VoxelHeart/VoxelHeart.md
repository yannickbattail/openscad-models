# Voxel heart

Voxel heart fully made with openscad using equations from https://mathworld.wolfram.com/HeartSurface.html

You can use cube or sphere as voxels

files .3mf are in much higher resolution

## UPDATE

- v3: generate images, animations and models using [openscad-generate](https://github.com/yannickbattail/openscad-generate)
- v2: heartJewel
- v1: 1st design

## How to print it

Material: PLA, ABS ??? color ???

Other slicer options
- infill: 20% ???
- vase mode (Spiral): No ???
- ...

## Customizable variables

- `resolution:` Size of a voxel and so then number of voxels. It takes an exponential time to process. Look at the
  console for "Number of voxels". (value lower than 0.03 will cause an error)
- `use_sphere:` Use sphere or cube as voxels. Using sphere takes a lot of time, check the value of $fn for better
  rendering time.
- `hull_that:` Do a hull() on all voxels. It looks smoother, but it takes a lot of time.
- `alternative_design:` Another design of the heart using the second equation.
- `$fn:` when use_sphere=true, values greater than 20 will take a lot of time.

## Sources

Sources available [here](https://github.com/yannickbattail/openscad-models/tree/main/VoxelHeart)

## Generate

Command to generate for all the presets: png image, webp animation, 3mf 3D model and mosaic of all the presets

```bash
npx openscad-generate@latest generate --mosaicFormat 3,2 --configFile VoxelHeart.yaml ./VoxelHeart.scad
```

You can add the option `--parallelJobs 7` before the .scad file to generate in parallel. (optimal number is your CPU number of cores minus 1)

Doc of [openscad-generate](https://github.com/yannickbattail/openscad-generate)

## Other interesting designs

- EasiestHeart
- heartJewel
- VoxelHeart

## License

[GPL](https://www.gnu.org/licenses/gpl-3.0.html)

[CC BY](https://creativecommons.org/licenses/by/4.0/)

## Keywords

jewelry, pendant, heart, puzzle, cat, openscad, customizable, customizer
