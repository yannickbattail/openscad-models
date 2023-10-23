// number of Pumpkin slices
slices = 10; // [6 : 12]
// put a little Pumpkin on the handle
PumpkinOnHandle = true;
// on which side of the mug the face of the pumpkin is
PumpkinFaceOrientation = 0; // [0:right, 270:front, 180:left]
// random seed, if seed=0 no random slice
seed = 1; // [0: 255]

// debug: cut in quarter
debug = false;

/* [Animation] */
// rotating animation
animation_rotation = false;

$fn = 100;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated?[0, 0, 0]:[];
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:[]; // animation rotate around the object
$vpd = is_animated?500:[];

PumpkinMug(slices, PumpkinOnHandle, PumpkinFaceOrientation, seed);

module PumpkinMug(slices, PumpkinOnHandle, PumpkinFaceOrientation, seed) {
    difference() {
        union() {
            scale([0.28, 0.28, 0.5])
                PumpkinBody(slices, PumpkinFaceOrientation, seed);
            translate([55, 0, 0])
                handle(100);
            if (PumpkinOnHandle) {
                translate([55, 0, 40])
                    scale([0.07, 0.07, 0.07])
                        Pumpkin(slices, PumpkinFaceOrientation, seed);
            }
        }
        // flat bottom
        translate([0, 0, - 105])
            cube([110, 110, 110], center = true);
        // remove top
        translate([0, 0, 104])
            cube([110, 110, 110], center = true);
        translate([0, 0, - 42])
            nutellaGlass();
        if (debug) {
            translate([0, 0, - 50])
                cube([100, 100, 100]);
            #translate([0, 0, - 42])
                nutellaGlass();
        }
    }
}

module handle(height) {
    color("orange")
        scale([0.4, 1.2, 0.65]) {
            rotate([90, 0, 0]) {
                torus(height / 2, 8);
            }
        }
}

module torus(radius, thickness) {
    rotate_extrude() {
        translate([radius, 0]) circle(r = thickness);
    }
}

module Pumpkin(slices, PumpkinFaceOrientation, seed) {
    PumpkinBody(slices, PumpkinFaceOrientation, seed);
    PumpkinTail();
    PumpkinBottom();
}

function rndAround(around, moreOrLess, seed)
= rands(around - moreOrLess, around + moreOrLess, 1, seed)[0];
function rndAroundN(around, moreOrLess, number, seed)
= rands(around - moreOrLess, around + moreOrLess, number, seed);

module PumpkinBody(slices, PumpkinFaceOrientation, seed) {
    difference() {
        PumpkinBase();
        color("yellow")
            translate([0, 0, - 70])
                rotate([90, 0, PumpkinFaceOrientation])
                    scale([4, 4, 4])
                        linear_extrude(50)
                            PumpkinFace();
    }
}

module PumpkinBase() {
    randSlices = rndAroundN(30, 8, slices, seed);
    color("orange")
        for (a = [0:slices - 1]) {
            rotate([0, 0, 360 / slices * a]) {
                r = seed?randSlices[a]:30;
                translate([r, 0, 0]) {
                    scale([1.5, 0.9, 1.2])
                        sphere(100);
                }
            }
        }
}

module PumpkinTail() {
    color("green")
        translate([0, 0, 110])
            linear_extrude(50, twist = 200, scale = 0.5)
                translate([8, 0])
                    circle(14);
}

module PumpkinBottom() {
    color("green")
        rotate([180, 0, 0])
            translate([0, 0, 115])
                linear_extrude(10, scale = 0.6)
                    circle(26);
}

module PumpkinFace() {
    PumpkinHalfFace();
    mirror(v = [1, 0, 0]) {
        PumpkinHalfFace();
    }
}
module PumpkinHalfFace() {
    polygon([
            [0, 0],
            [0, 7],
            [4, 6],
            [8, 10],
            [12, 9],
            [16, 13],
            [20, 13],
            [23, 14],
            [24, 12 - 4],
            [20, 13 - 5],
            [16, 9 - 5],
            [12, 11 - 6],
            [8, 7 - 6],
            [4, 8 - 6],
        ]);
    polygon([
            [12, 32],
            [20, 24],
            [4, 24],
        ]);
}

module nutellaGlass() {
    echo("nutellaGlass: total height 92");
    echo("nutellaGlass: max diameter 73.5");
    translate([0, 0, 25])
        difference() {
            union() {
                cylinder(d1 = 69.5, d2 = 73.5, h = 67);
                sphere(d = 69.5);
            }
            translate([0, 0, - 40 - 25])
                cube([80, 80, 80], center = true);
        }
}
