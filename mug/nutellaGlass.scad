part = "nutellaGlass"; // [nutellaGlass, emptyNutellaGlass]

/* [Animation] */
// rotating animation
animation_rotation = false;

$fn = 100;

// cut the glass in quarter
debug = false;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated?[0, 0, 0]:[];
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:[]; // animation rotate around the object
$vpd = is_animated?500:[];

if (debug) {
    difference() {
        emptyNutellaGlass(part == "emptyNutellaGlass");
        translate([0, - 200, - 0.1]) cube(200);
    }
} else {
    emptyNutellaGlass(part == "emptyNutellaGlass");
}

module nutellaGlass(empty = false) {
    echo("nutellaGlass: total height 92");
    echo("nutellaGlass: max diameter 73.5");
    if (empty) {
        emptyNutellaGlass();
    } else {
        fullNutellaGlass();
    }
}

module fullNutellaGlass() {
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

module emptyNutellaGlass() {
    difference() {
        fullNutellaGlass();
        translate([0, 0, 5])
            scale(0.95)
                fullNutellaGlass();
    }
}
