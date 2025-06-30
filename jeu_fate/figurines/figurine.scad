
// part to generate
part = "red"; // [red:feu, yellow:air, green:terre, blue:eau]

// width
width = 24 ; // [20:1:30]

// size of the model
thickness = 5; // [3:1:10]

// tolerence
tolerence = 0.4; // [0.05:0.05:2]

// size of jeton
cavity = 17; // [1:1:25]

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
// constant epsilon
EPSI = 0.001;

color(part) {
  scale(cavity) {
    if (part == "red") {
      fig_feu(width, thickness, tolerence, cavity);
    } else if (part == "yellow") {
      fig_air(width, thickness, tolerence, cavity);
    } else if (part == "green") {
      fig_terre(width, thickness, tolerence, cavity);
    } else if (part == "blue") {
      fig_eau(width, thickness, tolerence, cavity);
    } else {
      assert(false, "unknown part");
    }
  }
}

module fig_feu(width, thickness, tolerence, cavity) {
  union() {
    difference() {
      import("orig_stl/feu.stl");
      translate([0, 0, -2 + 0.125])
        cube([4, 4, 4], center = true);
    }
    cylinder(d = 1, h = 0.125);
  }
}

module fig_air(width, thickness, tolerence, cavity) {
  union() {
    difference() {
      translate([0, 0, 1])
      scale(0.001)
        import("orig_stl/air.stl");
      translate([0, 0, -2 + 0.125])
        cube([4, 4, 4], center = true);
    }
    cylinder(d = 1, h = 0.125);
  }
}

module fig_terre(width, thickness, tolerence, cavity) {
  union() {
    difference() {
      translate([0, 0, 1 - 0.06])
        scale(0.001)
          import("orig_stl/terre.stl");
      translate([0, 0, -2 + 0.125])
        cube([4, 4, 4], center = true);
    }
    cylinder(d = 1, h = 0.125);
  }
}

module fig_eau(width, thickness, tolerence, cavity) {
  union() {
    difference() {
      translate([0, 0, 1-0.03])
        scale(0.001)
          import("orig_stl/eau.stl");
      translate([0, 0, -2 + 0.125])
        cube([4, 4, 4], center = true);
    }
    cylinder(d = 1, h = 0.125);
  }
}
