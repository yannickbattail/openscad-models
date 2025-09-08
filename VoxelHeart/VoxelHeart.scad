// Size of a voxel and so then number of voxels. It takes an exponential time to process. Look at the console for "Number of voxel". (value lower than 0.03 will cause an error)
resolution=0.05; // [0.02:0.01:0.1]

// Use sphere or cube as voxels. Using sphere takes a lot of time, check the value of $fn for better rendering time.
use_sphere=false;

// Do a hull() on all voxels. It takes a lot of time. It looks smoother but it makes the 2 bumps of the heart disappear.
hull_that=false;

// Another design design of the heart using the second equation.
alternative_design=false;

// when use_sphere=true , values greater than 20 will will take a lot of time.
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
    fullHeart() quarterHeart(res, hull_that) children(0);
}

module fullHeart() {
    if (hull_that) {
        hull() halfHeart() children(0);
        mirror([1, 0, 0]) {
            hull() halfHeart() children(0);
        }
    } else {
        halfHeart() children(0);
        mirror([1, 0, 0]) {
            halfHeart() children(0);
        }
        
    }
}


module halfHeart() {
    children(0);
    mirror([0,1,0]) {
        children(0);
    }
}

module quarterHeart(res, hull_that) {
    // equations from https://mathworld.wolfram.com/HeartSurface.html
    function heart1(x, y, z) = (x^2 + 9/4*y^2 + z^2-1)^3 - x^2*z^3 - 9/80*y^2*z^3;
    function heart2(x, y, z) = (2*x^2 + 2*y^2 + z^2-1)^3 - 1/10*x^2*z^3 - y^2*z^3;

    points = [
        for (x = [0:res:1.5])
        for (y = [0:res:1.5])
        for (z = [-1.5:res:1.5])
        let (h = alternative_design ? heart2(x, y, z) :  heart1(x, y, z))
        if (h < 0) [x, y, z]
        ];
    echo("Number of voxel: ", len(points));
    voxelize(points) children(0);
}

module voxelize(points) {
    for (p = points)
    translate(p)
        children(0);
}
