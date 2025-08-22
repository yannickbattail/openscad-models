// part to generate
part = "all"; // [all, opinel, fundationAndVirole, DEBUGall]
///fundation, virole,

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
$vpd = is_animated?1000:$vpd;

EPSI = 0.01; // constant epsilon for the difference operation

if (part == "opinel") {
  opinel_saber();
} else if (part == "fundationAndVirole") {
  fundation_virole();
} else if (part == "DEBUGall") {
  fundation_virole(true);
} else {
  opinel_saber();
  fundation_virole();
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

module fundation_virole(debug = false) {
  radius = 15.7;
  height = 52;
  thinkness = 6;
  union() {
    fundation();
    virole(radius, height, thinkness);
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
  diameter = fundation?d:d + looseCoef;
  translate([0, 0, -206])
    cylinder(h = 206, d = diameter);
}

module bladeHole() {
  cylinder(h = 206, d1 = 25, d2 = 25);
  translate([0, 0, -206 - EPSI])
    cylinder(h = 206 + 2 * EPSI, d1 = 26.16, d2 = 25);
}

module virole(radius = 15.7, height = 52, thinkness = 6) {
  angleOpening = 20;
  di = 10;
  color("silver") {
    translate([0, 0, -height]) {
      rotate_extrude(start = angleOpening / 2 + 180, angle = 360 - angleOpening) {
        rotate([0, 0, 90]) {
          difference() {
            union() {
              square([height, radius + thinkness]);
              translate([height / 2, radius])
                circle(r = di);
            }
            union() {
              translate([-EPSI, -EPSI])
                square([height + 2 * EPSI, radius]);
              translate([height / 2, radius])
                circle(r = di - thinkness);
            }
          }
        }
      }
    }
  }
  color("DarkGray") {
    difference() {
      cylinder(h = thinkness, r = radius + thinkness);
      translate([0, 0, -EPSI])
        cylinder(h = thinkness + 2 * EPSI, d = 25);
    }
  }
  color("DarkGray") {
    difference() {
      cylinder(h = thinkness, r = radius + thinkness);
      translate([0, 0, -EPSI])
        cylinder(h = thinkness + 2 * EPSI, d = 25);
    }
  }
}
