// whole part curve (diameter)
d = 45; // [30:100]
// height of the part
h = 10; // [5:20]
// length of the part
l = 80; // [30:150]
// thickness of the tube
thickness = 1; // [0.2:0.1:3]
// tolerance space between the tube and blade
tolerance = 2; // [0.2:0.1:5]

// resolution
$fn = 200;

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated ? [0, 0, 0] : $vpt;
$vpr = is_animated ? [60, 0, animation_rotation ? (365 * $t) : 45] : $vpr; // animation rotate around the object
$vpd = is_animated ? 200 : $vpd;

// epsilon
epsi = 0.01;

saberSupport();

module saberSupport() {
  INCH = 25.4;
  hole = INCH + tolerance;
  difference() {
    union() {
      color("Silver")
        translate([0, 0, -d / 2 + h])
          rotate([0, 90, 0])
            cylinder(d = d, h = l, center = true);
      color("Gray")
        cylinder(d = hole + thickness * 2, h = h);
    }
    translate([0, 0, -d / 2])
      cube([l + epsi, d + epsi, d], center = true);
    // balde hole
    color("red")
      cylinder(d = hole, h = 80, center = true);
  }
}
