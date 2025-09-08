// part to generate
part = "opinel"; // [opinel]

/* [Animation] */
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

if (part == "opinel") {
  opinel_saber();
} else {
  assert(false, "Unknown part: " + part);
}

module stick(size) {
  color("green") rotate([0, 90, 0]) cylinder(d = size / 2, h = size * 1.25, center = true);
}

module opinel_saber() {
  difference() {
    scale(2.3)
      opinel();
    bladeHole();
  }
}

module opinel() {
  // translate([-11.5,-11.5,-75]) // translate to virole
  translate([-11.5,-11.5,-96.75])
    rotate([90,0,90])
      color("BurlyWood")
        import("opinel.stl");
}

module bladeHole() {
    cylinder(h = 206, d1 = 25, d2 = 25);
    translate([0, 0, -206])
      cylinder(h = 206, d1 = 26.16, d2 = 25);
}
