// piece
part = "octogonal"; // [rond, carre, octogonal, jeton]
element = "red"; // [red:feu, yellow:air, green:terre, blue:eau, DarkSlateGray:noir, white:blanc]

// size of the model
thickness = 3; // [1:1:10]

//tolerence
tolerence = 0.2; // [0.05:0.05:2]

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
epsi = 0.001;

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
        cylinder(d = 30, h = thickness, center = true);
        holes(thickness, tolerence);
    }
}

module carre(thickness, tolerence) {
    difference() {
        cube([30, 30, thickness], center = true);
        holes(thickness, tolerence);
    }
}

module octogonal(thickness, tolerence) {
    difference() {
        intersection() {
            cube([30, 30, thickness], center = true);
            rotate([0, 0, 45])
                cube([30, 30, thickness], center = true);
        }
        holes(thickness, tolerence);
    }
}

module jeton(thickness, tolerence) {
    cylinder(d = 10, h = thickness * 2 / 3, center = true);
}

module holes(thickness, tolerence) {
    translate([0, 0, thickness / 6])
        cylinder(d = 10 + tolerence, h = thickness / 3 + epsi);
    translate([0, 0, -thickness * 3 / 6 - epsi])
        cylinder(d = 10 + tolerence, h = thickness / 3 + epsi);
}
