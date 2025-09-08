// size of a voxel and so then number of voxels, it takes an exponential time to process. look at the console for "Number of voxel" (values lower than 0.03 will cause an error)
resolution=0.05; // [0.02:0.01:0.1]

// use cube or sphere as voxels, using sphere takes a lots of time
use_sphere=false;

// do a hull() on all voxels, takes a lots of time. I looks smoother but it make the 2 bumps of the heart disapear.
hull_that=false;

// another design
alternative_design=false;

// $fn, when use_sphere=true . values greater than 20 will will take a lot of time
$fn=10;

/* [Animation] */
// rotating animation
animation_rotation = false;

/* for animation */
$vpt = animation_rotation ? [0, 0, 0] : [];
$vpr = animation_rotation ? [70, 0, 365 * $t] : [];
$vpd = animation_rotation ? 30 : [];

heart(resolution, hull_that) {
    if (use_sphere) {
        sphere(resolution*2);
    } else {
        cube(resolution*1.0001, center = true); // * 1.0001 this is juste to make sure the cubes realy touch each other
    }
}

module heart(res=0.05, hull_that=false) {
    // equations from https://mathworld.wolfram.com/HeartSurface.html
    function heart1(x, y, z) = (x^2 + 9/4*y^2 + z^2-1)^3 - x^2*z^3 - 9/80*y^2*z^3;
    function heart2(x, y, z) = (2*x^2 + 2*y^2 + z^2-1)^3 - 1/10*x^2*z^3 - y^2*z^3;

    points = [
        for (x = [-1.5:res:1.5])
            for (y = [-1.5:res:1.5])
                for (z = [-1:res:1.5])
                    let (h = alternative_design ? heart2(x, y, z) :  heart1(x, y, z))
                    if (h < 0 /*&& h > -res*/) [x, y, z]
    ];
    echo("Number of voxel: ", len(points));
    if (hull_that) {
        hull() {
            voxelize(points) children(0);
        }
    } else {
        voxelize(points) children(0);
    }
}

module voxelize(points) {
    for (p = points) {
        translate(p) {
            children(0);
        }
    }
}
