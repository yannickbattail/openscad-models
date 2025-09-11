// part to generate
part = "all"; // [all, handle, pommel, foundation]

// collapsable blade or standard 1 inch blade
collapsable = true;

// looseCoef
looseCoef = 0.6; // [0.1:0.1:2]

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

EPSI = 0.01; // constant epsilon for the difference operation
INCH = 25.4;

if (part == "handle") {
  handle();
} else if (part == "pommel") {
  pommel();
} else if (part == "foundation") {
  if (collapsable) {
    foundation();
  } else {
    linear_extrude(10) text("No foundation for non collapsable blade", 20);
  }
} else {
  handle();
  pommel();
  if (collapsable) {
    foundation();
  }
  saberBlade(true);
}

module handle() {
  color("DarkGreen")
    difference() {
      wand();
      foundationHole();
      saberBlade(false);
    }
}

module pommel() {
  color("Green")
    difference() {
      wandPommel();
      foundationHole();
    }
}

module saberBlade(bladeItself) {
  bladeLength = 800;
  d = collapsable?27:INCH;
  bladeDiameter = bladeItself ? d : d + looseCoef;
  color("red", 0.5) {
    cylinder(h = bladeLength, d = bladeDiameter);
    translate([0, 0, bladeLength])
      sphere(d = bladeDiameter);
  }
}

module wand() {
  difference() {
    translate([0, -5, -100]) {
      scale(1.3) {
        rotate([180, 0, 0]) {
          import("model/gen/cthulhu-wand_3mf_partie1.3mf");
          import("model/gen/cthulhu-wand_3mf_partie2.3mf");
          import("model/gen/cthulhu-wand_3mf_partie3.3mf");
        }
      }
    }
    translate([0, 0, 323 + 50])
      cube(100, center = true);
  }
}

module wandPommel() {
  translate([0, -5, -100])
    scale(1.3)
      rotate([180, 0, 0]) {
        import("model/gen/cthulhu-wand_3mf_manche.3mf");
      }
}

module foundation() {
  color("blue")
    difference() {
      foundationHole(true);
      bladeHole();
    }
}

module foundationHole(foundationItself = false) {
  d = collapsable?27:INCH;
  diameter = foundationItself ? d : d + looseCoef;
  translate([0, 0, -206])
    cylinder(h = 206, d = diameter);
}

module bladeHole() {
  cylinder(h = 206, d1 = 25, d2 = 25);
  translate([0, 0, -206 - EPSI])
    cylinder(h = 206 + 2 * EPSI, d1 = 26.16, d2 = 25);
}
