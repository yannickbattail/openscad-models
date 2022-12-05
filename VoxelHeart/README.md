# Voxel heart

Voxel heart fully made with openscad using equations from https://mathworld.wolfram.com/HeartSurface.html

You can use cube or sphere as voxels

## Customisation variables

- **resolution:** Size of a voxel and so then number of voxels. It takes an exponential time to process. Look at the console for "Number of voxel". (value lower than 0.03 will cause an error)

- **use_sphere:** Use sphere or cube as voxels. Using sphere takes a lot of time, check the value of $fn for better rendering time.

- **hull_that:** Do a hull() on all voxels. It looks smoother but it takes a lot of time.

- **alternative_design:** Another design design of the heart using the second equation.

- **$fn:** when use_sphere=true , values greater than 20 will will take a lot of time.

## changelog

- Decrease rendering time by 4 by splitting the heart un quarter and using mirror().

# easiest_heart

A very simple code that generate a Heart.

## Customisation variables

- **scale_x** : heart bumps width

- **scale_y** : heart width

- **scale_z** : heart bumps length
