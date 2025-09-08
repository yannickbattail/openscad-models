// part to generate
part = "ball"; // [all, ball, stick]

// size of the model
size = 50; // [10:5:100]

/* [Animation] */
// resolution
$fn = 10;

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated ? [0, 0, 0] : $vpt;
$vpr = is_animated ? [60, 0, animation_rotation ? (365 * $t) : 45] : $vpr; // animation rotate around the object
$vpd = is_animated ? 200 : $vpd;

if (part == "ball") {
  ball(size);
} else if (part == "stick") {
  stick(size);
} else {
  ball(size);
  stick(size);
}

module stick(size) {
  color("green")
    rotate([0, 90, 0])
      cylinder(d = size / 2, h = size * 1.25, center = true);
}

module ball(size) {
  difference() {
    sphere(d = size);
    cylinder(d = size / 2, h = size * 1.25, center = true);
    #rotate([90, 0, 0])
      cylinder(d = size / 2, h = size * 1.25, center = true);
    stick(size);
  }
}
