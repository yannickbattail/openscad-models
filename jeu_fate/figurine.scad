// part to generate
part = "red"; // [red:feu, yellow:air, green:terre, blue:eau]

// width
width = 24 ; // [20:1:30]

// size of the model
thickness = 5; // [3:1:10]

// tolerence
tolerence = 0.4; // [0.05:0.05:2]

// size of jeton
cavity = 17 ; // [1:1:25]

// resolution
$fn = 100;

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated?[0, 0, 15]:$vpt;
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:$vpr;  // animation rotate around the object
$vpd = is_animated?100:$vpd;
// constant epsilon
EPSI = 0.001;

color(part) {
  union() {
    translate([0, 0, (thickness * 4 / 5 - tolerence) / 2]) {
      fig(part);
    }
    jeton(width, thickness, tolerence, cavity);
  }
}


module jeton(width, thickness, tolerence, cavity) {
  cylinder(d = cavity - tolerence, h = thickness * 4 / 5 - tolerence, center = true);
}

module fig(part) {
  if (part == "red") {
    import("figurines/feu.3mf");
  } else if (part == "yellow") {
    import("figurines/air.3mf");
  } else if (part == "green") {
    import("figurines/terre.3mf");
  } else if (part == "blue") {
    import("figurines/eau.3mf");
  } else {
    assert(false, "unknown part");
  }
}
