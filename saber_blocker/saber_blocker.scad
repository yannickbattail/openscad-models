// whole part curve (diameter)
d = 100; // [50:200]
// height of the part
h = 8;
// thickness of the tube
thickness = 1;
// tolerence space between the tube and blade
tolerence = 2;

// resolution
$fn = 200;

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated?[0, 0, 0]:$vpt;
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:$vpr;  // animation rotate around the object
$vpd = is_animated?200:$vpd;

saberSupport();

module saberSupport() {
    INCH = 25.4;
    hole = INCH + tolerence;
    difference() {
        union() {
            color("Silver")
                translate([0, 0, -d / 2 + h])
                    rotate([0, 90, 0])
                        cylinder(d = d, h = 80, center = true);
            color("Gray")
                cylinder(d = hole + thickness * 2, h = h);
        }
        translate([0, 0, -d / 2])
            cube(d, center = true);
        cylinder(d = hole, h = 80, center = true);
    }
}
