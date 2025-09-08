# easiest_heart

A very simple code that generates a Heart.

## How to print it

Material: *what you want* (silk red PLA is awesome)

Color: red

## Customisation variables

- `scale_x` : heart bumps width
- `scale_y` : heart width
- `scale_z` : heart bumps length

## Sources

Sources available [here](https://github.com/yannickbattail/openscad-models/tree/main/VoxelHeart/)

## Generate

Command to generate for all the presets: png image, webp animation, 3mf 3D model and mosaic of all the presets

```bash
npx openscad-generate@latest generate --outFormats png,webp,3mf --configFile EasiestHeart.yaml ./EasiestHeart.scad
```

You can add the option `--parallelJobs 7` before the .scad file to generate in parallel. (optimal number is your CPU
number of cores minus 1)

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
