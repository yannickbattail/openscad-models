// part to generate
part = "all"; // [all, handle, pomel, fundation]

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
$vpd = is_animated ? 200 : $vpd;

EPSI = 0.01; // constant epsilon for the difference operation

if (part == "handle") {
  handle();
} else if (part == "pomel") {
  pomel();
} else if (part == "fundation") {
  fundation();
} else {
  handle();
  pomel();
  fundation();
  saberBlade();
}

module handle() {
  color("DarkGreen")
    difference() {
      wand();
      fundationHole();
      saberBlade();
    }
}

module pomel() {
  color("Green")
    difference() {
      wandPommel();
      fundationHole();
    }
}

module saberBlade() {
  bladeLength = 800;
  bladeDiameter = 27;
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

module fundation() {
  color("blue")
    difference() {
      fundationHole(true);
      bladeHole();
    }
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
  diameter = fundation ? d : d + looseCoef;
  translate([0, 0, -206])
    cylinder(h = 206, d = diameter);
}

module bladeHole() {
  cylinder(h = 206, d1 = 25, d2 = 25);
  translate([0, 0, -206 - EPSI])
    cylinder(h = 206 + 2 * EPSI, d1 = 26.16, d2 = 25);
}
