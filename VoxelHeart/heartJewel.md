# Jewel cat heart pendant - puzzle piece

Jewel heart: it comes in 2 parts that can be put together like a puzzle

2 versions are available with ou without a cat.

The heart shape is based on the hulled [VoxelHeart](https://www.thingiverse.com/thing:5635344)

## Customisation variables

- `part:` part to generate: all, heartLeft or heartRight
- `cat:` true, add the drawing of the cat on the heart
- `voxelHeart:` false, use voxelHeart or easiest_heart
- `hull_that:` Do a hull() on all voxels. It looks smoother but it takes a lot of time.

## Sources

Sources available [here](https://github.com/yannickbattail/openscad-models/tree/main/VoxelHeart)

## Generate

Command to generate for all the presets: png image, webp animation, 3mf 3D model and mosaic of all the presets

```bash
npx openscad-generate@latest generate --outFormats png,webp,3mf --mosaicFormat 3,2 --configFile heartJewel.yaml ./heartJewel.scad
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

jewelry, pendant, heart, puzzle, cat
