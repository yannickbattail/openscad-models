// rounding of the dice
rounding = 0.69; // [0.6:0.01:0.8]

// hole size/depth
hole_size = 0.56; // [0.5:0.01:0.591]

// dice color
dice_color = "yellow"; // [yellow, red, green, blue, white, black]

// holes color
holes_color = "red"; // [yellow, red, green, blue, white, black]

// resolution
$fn = 40;

/* [Animation] */

// Animation rotation
animation_rotation = false;

// Animation rounding
animation_rounding = false;

// Animation hole_size
animation_hole_size = false;

/* [Hidden] */
is_animated = animation_rotation || animation_rounding || animation_hole_size;
$vpt = is_animated?[0, 0, 0]:$vpt;
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:$vpr; // animation rotate around the object
$vpd = is_animated?200:$vpd;

r = animation_rounding ? ($t * 0.2 + 0.6) : rounding;
h = animation_hole_size ? ($t * 0.091 + 0.5) : hole_size;
scale(50) dice(r, h, dice_color, holes_color);
module dice(rounding, hole_size, dice_color, holes_color) {
    difference() {
        color(dice_color) intersection() {
            cube(1, center = true);
            sphere(rounding);
        }
        color(holes_color) {
            holes(hole_size);
        }
    }
}

module holes(face) {
    c = 0.22;
    rotate([0, 0, 0]) translate([0, 0, face]) {// 1
        translate([0, 0, 0]) sphere(0.1);
    }
    rotate([180, 0, 0]) translate([0, 0, face]) {// 6
        translate([c, c, 0]) sphere(0.1);
        translate([c, 0, 0]) sphere(0.1);
        translate([c, - c, 0]) sphere(0.1);
        translate([- c, c, 0]) sphere(0.1);
        translate([- c, 0, 0]) sphere(0.1);
        translate([- c, - c, 0]) sphere(0.1);
    }
    rotate([90, 0, 0]) translate([0, 0, face]) {// 2
        translate([c, c, 0]) sphere(0.1);
        translate([- c, - c, 0]) sphere(0.1);
    }
    rotate([- 90, 0, 0]) translate([0, 0, face]) {// 5
        translate([0, 0, 0]) sphere(0.1);
        translate([c, c, 0]) sphere(0.1);
        translate([- c, c, 0]) sphere(0.1);
        translate([c, - c, 0]) sphere(0.1);
        translate([- c, - c, 0]) sphere(0.1);
    }
    rotate([90, 0, 90]) translate([0, 0, face]) {// 3
        #translate([c, c, 0]) sphere(0.1);
        #translate([0, - 0, 0]) sphere(0.1);
        #translate([- c, - c, 0]) sphere(0.1);
    }
    rotate([90, 0, - 90]) translate([0, 0, face]) {// 4
        #translate([c, c, 0]) sphere(0.1);
        #translate([- c, c, 0]) sphere(0.1);
        #translate([c, - c, 0]) sphere(0.1);
        #translate([- c, - c, 0]) sphere(0.1);
    }
}

