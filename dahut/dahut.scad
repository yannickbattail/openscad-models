// shrink factor for the legs
leg_shrink = 0.7; //[0.3:0.05:0.9]

// has rock under the feet like a sidewalk
has_rock = true;

// sens, dextrogyre shorter legs on right side, levogyre shorter legs on left side
sens = "dextrogyre"; // [dextrogyre, levogyre]

/* [resolution] */
// resolution
$fn = 10;

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [Hidden] */
is_animated = animation_rotation;
shrink = is_animated ? ($t * 0.6 + 0.3) : leg_shrink;
$vpt = is_animated ? [0, 0, 50] : $vpt;
$vpr = is_animated ? [70, 0, 20] : $vpr; // animation rotate around the object
$vpd = is_animated ? 400 : $vpd;

dahut(shrink, sens, has_rock);

module dahut(leg_shrink, sens, has_rock) {
  mirror([sens == "levogyre" ? 0 : 1, 0, 0]) {
    dahut_leg(leg_shrink, has_rock);
    dahut_body();
  }
}

module dahut_leg(shrink, has_rock) {
  translate([0, 0, 27.5 * (1 - shrink)]) {
    scale([1, 1, shrink]) {
      intersection() {
        dahut_base();
        translate([0, -40, 0])
          cube([20, 100, 27.5]);
      }
    }
  }
  if (has_rock) {
    color("green")
      translate([0, -40, 0])
        cube([20, 100, 27.5 * (1 - shrink)]);
  }
}

module dahut_body() {
  difference() {
    dahut_base();
    translate([0, -40, 0])
      cube([20, 100, 27.5]);
  }
}

module dahut_base() {
  difference() {
    import("goat.3mf");
    translate([0, 0, -50])
      cube(100, center = true);
  }
}
