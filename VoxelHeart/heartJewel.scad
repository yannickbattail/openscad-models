// part to generate
part = "all"; // [all, heartLeft, heartRight]

// add the cat on the heart
cat = true;

// voxelHeart or easiest_heart
voxelHeart = false;

// Size of a voxel and so then number of voxels. It takes an exponential time to process. Look at the console for "Number of voxel".
resolution = 0.05; // [0.02:0.01:0.1]

// Do a hull() on all voxels. It takes a lot of time. It looks smoother but it makes the 2 bumps of the heart disappear.
hull_that = true;

/* [Animation] */
// resolution
$fn = 50;

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated?[0, 0, 0]:$vpt;
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:$vpr;  // animation rotate around the object
$vpd = is_animated?300:$vpd;

use<EasiestHeart.scad>;
use<VoxelHeart.scad>;
use<cat/cat.scad>;

if (part == "heartLeft") {
    heartLeft();
} else if (part == "heartRight") {
    heartRight();
} else {
    scale(1.01)
        heartLeft();
    heartRight();
}

module baseHeart() {
    difference() {
        if (voxelHeart) {
            scale(24)
                heart(resolution, hull_that)
                cube(resolution * 1.0001, center = true);
            // * 1.0001 this is juste to make sure the cubes realy touch each other
        } else {
            easiest_heart();
        }
        if (cat) {
            translate([0, -9, 4.5])
                rotate([90, 0, 0])
                    linear_extrude(6)
                        scale(0.04)
                            cat_svg();
        }
    }
}

module heartLeft() {
    difference() {
        color("blue")
            intersection() {
                baseHeart();
                scale(0.2)
                    rotate([90, 0, 0])
                        linear_extrude(200, center = true)
                            puzzleConnection(0)
                            easiest_heart();
            }
        translate([25, 0, 25])
            rotate([90, 0, 0])
                torus(10, 2);
    }
}

module heartRight() {
    difference() {
        color("red")
            difference() {
                baseHeart();
                scale(0.2)
                    rotate([90, 0, 0])
                        linear_extrude(200, center = true)
                            puzzleConnection(1)
                            baseHeart();
            }
        translate([-25, 0, 25])
            rotate([90, 0, 0])
                torus(10, 2);
    }
}

module puzzleConnection(offsetPuzzle) {
    offset(offsetPuzzle) {
        translate([-20, 0])
            rotate([0, 0, 90]) {
                translate([0, -10])
                    square(40, center = true);
                projection(cut = true)
                    rotate([-90, 0, 0])
                        children();
            }
        translate([200, 0, 0])
            square(400, center = true);
    }
}

module torus(radius, thickness) {
    rotate_extrude() {
        translate([radius, 0]) circle(r = thickness);
    }
}
