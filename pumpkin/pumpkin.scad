include <../mug/nutellaGlass.scad>;

// number of pumkin slices
slices = 10; // [6 : 12]
// put a litte pumkin on the handle
pumkinOnHandle = true;
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
$vpt = is_animated?[0, 0, 0]:$vpt;
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:$vpr; // animation rotate around the object
$vpd = is_animated?500:$vpd;

pumkinMug(slices, pumkinOnHandle, seed);

module pumkinMug(slices, pumkinOnHandle, seed) {
    difference() {
        union() {
            scale([0.28, 0.28, 0.5])
                pumkinBase(slices, seed);
            translate([55, 0, 0])
                handle(100);
            if (pumkinOnHandle) {
                translate([55, 0, 40])
                    scale([0.07, 0.07, 0.07])
                        pumkin(slices, seed);
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

module pumkin(slices, seed) {
    pumkinBase(slices, seed);
    pumkinTail();
    pumkinBottom();
}

function rndAround(around, moreOrLess, seed)
    = rands(around - moreOrLess, around + moreOrLess, 1, seed)[0];
function rndAroundN(around, moreOrLess, number, seed)
    = rands(around - moreOrLess, around + moreOrLess, number, seed);

module pumkinBase(slices, seed) {
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

module pumkinTail() {
    color("green")
        translate([0, 0, 110])
            linear_extrude(50, twist = 200, scale = 0.5)
                translate([8, 0])
                    circle(14);
}

module pumkinBottom() {
    color("green")
        rotate([180, 0, 0])
            translate([0, 0, 115])
                linear_extrude(10, scale = 0.6)
                    circle(26);
}
