# Simple customizable heart

A very simple code that generates a Heart.

## Updates

- v1: 1st design

## How to print it

Material: *what you want* (silk red PLA is awesome)

Color: red

## Customizable variables

- `scale_x` : heart bumps width
- `scale_y` : heart width
- `scale_z` : heart bumps length

## Sources

Sources available [here](https://github.com/yannickbattail/openscad-models/tree/main/VoxelHeart/)

## Generate

Command to generate for all the presets: png image, webp animation, 3mf 3D model and mosaic of all the presets

```bash
npx openscad-generate@latest generate --mosaicFormat 2,2 --configFile EasiestHeart.yaml ./EasiestHeart.scad
```

You can add the option `--parallelJobs 7` before the .scad file to generate in parallel. (optimal number is your CPU number of cores minus 1)

Doc of [openscad-generate](https://github.com/yannickbattail/openscad-generate)

## Other interesting designs

- [Voxel Heart full openscad](https://www.thingiverse.com/thing:5635344)
- [Jewel heart pendant - puzzle piece](https://www.thingiverse.com/thing:6885816)
- [Cat heart pendant - puzzle piece](https://www.thingiverse.com/thing:6909146)

## License

[GPL](https://www.gnu.org/licenses/gpl-3.0.html)

[CC BY](https://creativecommons.org/licenses/by/4.0/)
