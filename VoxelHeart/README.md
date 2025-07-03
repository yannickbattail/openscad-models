# Voxel heart

Voxel heart fully made with openscad using equations from https://mathworld.wolfram.com/HeartSurface.html

You can use cube or sphere as voxels

files .3mf are in much higher resolution

## UPDATE

- v3: generate images, animations and models
  using [openscad-generate](https://github.com/yannickbattail/openscad-generate)
- v2: heartJewel
- v1: 1st design

## Customisation variables

- `resolution:` Size of a voxel and so then number of voxels. It takes an exponential time to process. Look at the
  console for "Number of voxels". (value lower than 0.03 will cause an error)
- `use_sphere:` Use sphere or cube as voxels. Using sphere takes a lot of time, check the value of $fn for better
  rendering time.
- `hull_that:` Do a hull() on all voxels. It looks smoother, but it takes a lot of time.
- `alternative_design:` Another design of the heart using the second equation.
- `$fn:` when use_sphere=true, values greater than 20 will take a lot of time.

## changelog

- generate 3D models in high resolution with manifold enabled
- Decrease rendering time by 4 by splitting the heart un quarter and using mirror().

# easiest_heart

A very simple code that generates a Heart.

## Customisation variables

- `scale_x` : heart bumps width
- `scale_y` : heart width
- `scale_z` : heart bumps length

# Jewel cat heart pendant - puzzle piece

Jewel heart: it comes in 2 parts that can be put together like a puzzle

2 versions are available with ou without a cat.

The heart shape is based on the hulled [VoxelHeart](https://www.thingiverse.com/thing:5635344)

Sources available [here](https://github.com/yannickbattail/openscad-models/tree/main/VoxelHeart)

## Customisation variables

- `part:` part to generate: all, heartLeft or heartRight
- `cat:` true, add the drawing of the cat on the heart
- `voxelHeart:` false, use voxelHeart or easiest_heart
- `hull_that:` Do a hull() on all voxels. It looks smoother but it takes a lot of time.

## Keywords

jewelry, pendant, heart, puzzle, cat

## Generate

Command to generate for all the presets: png image, webp animation, 3mf 3D model and mosaic of all the presets

```bash
npx openscad-generate@latest generate --outFormats png,webp,3mf --mosaicFormat 2,1 --configFile EasiestHeart.yaml ./EasiestHeart.scad
npx openscad-generate@latest generate --outFormats png,webp,3mf --mosaicFormat 3,2 --configFile VoxelHeart.yaml ./VoxelHeart.scad
npx openscad-generate@latest generate --outFormats png,webp,3mf --mosaicFormat 3,2 --configFile heartJewel.yaml ./heartJewel.scad
```

You can add the option `--parallelJobs 7` before the .scad file to generate in parallel. (optimal number is your CPU
number of cores minus 1)

Doc of [openscad-generate](https://github.com/yannickbattail/openscad-generate)

## License

[GPL](https://www.gnu.org/licenses/gpl-3.0.html)

[CC BY](https://creativecommons.org/licenses/by/4.0/)
