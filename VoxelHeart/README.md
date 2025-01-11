# Voxel heart

Voxel heart fully made with openscad using equations from https://mathworld.wolfram.com/HeartSurface.html

You can use cube or sphere as voxels

files .3mf are in much higher resolution

## Customisation variables

- **resolution:** Size of a voxel and so then number of voxels. It takes an exponential time to process. Look at the
  console for "Number of voxel". (value lower than 0.03 will cause an error)
- **use_sphere:** Use sphere or cube as voxels. Using sphere takes a lot of time, check the value of $fn for better
  rendering time.
- **hull_that:** Do a hull() on all voxels. It looks smoother but it takes a lot of time.
- **alternative_design:** Another design design of the heart using the second equation.
- **$fn:** when use_sphere=true , values greater than 20 will will take a lot of time.

## changelog

- generate 3D models in high resolution with manifold enabled
- Decrease rendering time by 4 by splitting the heart un quarter and using mirror().

# easiest_heart

A very simple code that generate a Heart.

## Customisation variables

- **scale_x** : heart bumps width
- **scale_y** : heart width
- **scale_z** : heart bumps length

# Jewel cat heart pendant - puzzle piece

Jewel heart: it comes in 2 parts that can be put together like a puzzle

2 versions are available, with ou without a cat.

The heart shape is based on the hulled [VoxelHeart](https://www.thingiverse.com/thing:5635344)

Sources available [here](https://github.com/yannickbattail/openscad-models/tree/main/VoxelHeart)

## Customisation variables

- **part:** part to generate: all, heartLeft or heartRight
- **cat:** true, add the drawing of the cat on the heart
- **voxelHeart:** false, use voxelHeart or easiest_heart
- **hull_that:** Do a hull() on all voxels. It looks smoother but it takes a lot of time.

## Keywords

jewelry, pendant, heart, puzzle, cat
