// part to generate
part = "opinel"; // [all, opinel, fundation]

// looseCoef
looseCoef = 0.6; // [0.1:0.1:2]

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
} else if (part == "fundation") {
  fundation();
} else {
  opinel_saber();
  fundation();
}

module opinel_saber() {
  difference() {
    scale(2.5)
      opinel();
    fundationHole();
  }
}

module opinel() {
  // translate([-11.3, -11.55, -75]) // translate to virole
  translate([-11.3, -11.55, -96.8])
    rotate([90, 0, 90])
      color("BurlyWood")
        import("opinel.stl");
}


module fundation() {
  color("blue")
    difference() {
      fundationHole(true);
      bladeHole();
    }
}

module fundationHole(fundation = false) {
  d = 27;
  diameter = fundation?d:d + looseCoef;
  translate([0, 0, -206])
    cylinder(h = 206, d = diameter);
}

module bladeHole() {
  cylinder(h = 206, d1 = 25, d2 = 25);
  translate([0, 0, -206])
    cylinder(h = 206, d1 = 26.16, d2 = 25);
}
