// piece
part = "octogonal"; // [rond, carre, octogonal, jeton]
element = "red"; // [red:feu, yellow:air, green:terre, blue:eau, DarkSlateGray:noir, white:blanc]

// width
width = 24 ; // [20:1:30]

// size of the model
thickness = 5; // [3:1:10]

// tolerence
tolerence = 0.4; // [0.05:0.05:2]

// cavity
cavity = 17 ; // [1:1:25]

// epsilon
epsi = 0.1; // [0.05:0.05:0.25]

// resolution
$fn = 100;

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated?[0, 0, 0]:$vpt;
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:$vpr;  // animation rotate around the object
$vpd = is_animated?200:$vpd;


color(element) {
    if (part == "rond") {
        rond(thickness, tolerence);
    } else if (part == "carre") {
        carre(thickness, tolerence);
    } else if (part == "octogonal") {
        octogonal(thickness, tolerence);
    } else if (part == "jeton") {
        jeton(thickness, tolerence);
    } else {
        assert(false, "unknown part");
    }
}

module rond(thickness, tolerence) {
    difference() {
        cylinder(d = width, h = thickness, center = true);
        holes(thickness);
    }
}

module carre(thickness, tolerence) {
    difference() {
        cube([width, width, thickness], center = true);
        holes(thickness);
    }
}

module octogonal(thickness, tolerence) {
    difference() {
        intersection() {
            cube([width, width, thickness], center = true);
            rotate([0, 0, 45])
                cube([width, width, thickness], center = true);
        }
        holes(thickness);
    }
}

module jeton(thickness, tolerence) {
    cylinder(d = cavity - tolerence, h = thickness * 4 / 5 - tolerence, center = true);
}

module holes(thickness) {
    cavity_depth = 2/5 * thickness;
    translate([0, 0, (thickness - cavity_depth)/2 + epsi] )
        cylinder(d = cavity, h = cavity_depth + 2 * epsi, center=true);
    translate([0, 0, -(thickness - cavity_depth)/2 - epsi] )
        cylinder(d = cavity, h = cavity_depth + 2 * epsi, center=true);
}
