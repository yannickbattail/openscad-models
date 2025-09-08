// part to generate
part = "all"; // [all, wand, orb, fixation]

/* [Animation] */
// resolution
$fn = 100;

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated ? [0, 0, 0] : $vpt;
$vpr = is_animated ? [60, 0, animation_rotation ? (365 * $t) : 45] : $vpr; // animation rotate around the object
$vpd = is_animated ? 1000 : $vpd;

model2d();

module model2d() {
  if (part == "wand") {
    wand();
  } else if (part == "orb") {
    orb();
  } else if (part == "fixation") {
    fixation();
  } else {
    orb();
    fixation();
    rotate([0, 180, 180]) {
      wand();
    }
  }
}

module orb() {
  color("DarkSlateGray")
    cylinder(h = 50, d1 = 100, d2 = 65);
  color("darkviolet")
    translate([0, 0, 80])
      sphere(d = 75);
}

module fixation() {
  color("green")
    difference() {
      translate([0, 0, -10])
        cylinder(h = 20, d = 102);
      cylinder(h = 11, d1 = 100, d2 = 93);
      translate([0, 0, -10.001])
        cylinder(h = 10.002, d = 100);
    }
}

module wand() {
  difference() {
    union() {
      rotate_extrude()
        difference() {
          square([50, 50]);
          translate([80, 50])
            circle(r = 50);
        }
      rotate_extrude()
        color("orange")
          polygon([
            [0, 50],
            [30, 50],
            [25, 55],
            [34, 60],
            [25, 65],
            [23, 70],
            [22, 75],
            [0, 75],
          ]);
      handle();
    }
    translate([0, 0, 60])
      bladeHole();
    translate([0, 0, -0.001])
      cylinder(h = 61, d = 26.16);
  }
}

module handle() {
  t = 10;
  translate([0, 0, 75]) {
    cylinder(r = 22, h = t);
  }
  translate([0, 0, 75 + t / 2]) {
    torus(20, t / 2);
  }
  translate([0, 0, 75 + t]) {
    linear_extrude(180, twist = 360)
      circle(r = 22, $fn = 8);
    linear_extrude(180, twist = -360)
      circle(r = 22, $fn = 8);
    linear_extrude(180, twist = 0)
      circle(r = 22, $fn = 8);
  }
  u = 75 + 180;
  translate([0, 0, u]) {
    cylinder(r = 22, h = t);
  }
  translate([0, 0, 75 + 180 + t / 2]) {
    torus(20, t / 2);
  }
}

module torus(radius, thickness) {
  rotate_extrude() {
    translate([radius, 0])
      circle(r = thickness);
  }
}
module bladeHole() {
  in = 26.16;
  out = 25;
  cylinder(h = 206, d1 = in, d2 = out);
}
