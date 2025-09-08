part = "all"; // [all, base, support]

number_of_rows = 16; // [1:1:40]
number_of_column = 5; // [1:1:40]

// positioning of the focus point
focus_of_parabola = "middle"; // [middle, bottom_center, bottom_left]

// when part=support, it only show the support at row Y
support_at_row = "1";
// when part=support, it only show the support at column X
support_at_column = "A";

// distance of the focus point
focus_distance = 1000; // [100:2000]

// thickness of the base
base_height = 2; // [1:10]

// support height (from the bottom of the base)
support_height = 60; // [35:100]

// add the base to the display
show_base = true;

// display CD, light rays, focus point and coordinates
debug = true;

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [hidden] */
$fn = 100;

$vpt = animation_rotation ? [0, 0, 0] : [];
$vpr = animation_rotation ? [70, 0, 365 * $t] : [];
$vpd = animation_rotation ? 300 : [];

// constants
baseSide = 120;
baseDiameter = baseSide / (sqrt(3) / 2);
baseRadius = baseDiameter / 2;

dimentions = [positionX(number_of_column, number_of_rows), positionY(number_of_column, number_of_rows)];

if (part == "all" || part == "support") {
  solar_oven(base_height, support_height, baseDiameter);
} else if (part == "base") {
  base(base_height, baseDiameter);
}

module solar_oven(base_height, support_height, baseDiameter) {
  focusPos = focus_position(focus_of_parabola, dimentions, focus_distance);
  for(x = [0:number_of_column - 1]) {
    if (debug) {
      color("blue")
        translate([positionX(x, 0) + 40, -150, 0])
          linear_extrude(2)
            text(chr(65 + x), 50);
    }
    for(y = [0:number_of_rows - 1]) {
      xt = positionX(x, y);
      yt = positionY(x, y);
      row_name = str(y + 1);
      column_name = chr(65 + x);
      if (part == "all" || (part == "support" && column_name == support_at_column && row_name == support_at_row)) {
        supportRotation = support_rotation(focusPos, [xt, yt, support_height]);
        translate([xt, yt, 0]) {
          if (show_base && part == "all") {
            base(base_height, baseDiameter);
          }
          support(str(column_name, ",", row_name), supportRotation, support_height, base_height);
        }
      }
    }
  }
  if (debug) {
    color("lightyellow")
      translate(focusPos)
        sphere(10); // display focus point
    for(y = [0:number_of_rows - 1]) {
      color("blue")
        translate([-150, positionY(0, y) - 24, 0])
          linear_extrude(2)
            text(str(y + 1), 50);
    }
  }
}

function positionX(x, y) =
  y % 2 ? x * baseRadius * 3 + baseRadius * 1.5 : x * baseRadius * 3;
function positionY(x, y) =
  y * baseSide / 2;

function focus_position(focus_of_parabola, dimentions, focus_distance) =
  focus_of_parabola == "middle" ? [dimentions[0] / 2, dimentions[1] / 2, focus_distance] : (focus_of_parabola == "bottom_center" ? [dimentions[0] / 2, 0, focus_distance] : /*bottom_left*/
  [0, 0, focus_distance]);

function support_rotation(focusPos, support) =
  let (vect = focusPos - support, sphrCord = sphericalCoord(vect))
    [0, sphrCord[1] / 2, sphrCord[2]];

function sphericalCoord(vect) =
  let (length = norm([vect[0], vect[1], vect[2]]), // radial distance
  theta = acos(vect[2] / length), // inclination angle
  phi = atan2(vect[1], vect[0]) // azimuthal angle
  )
    [length, theta, phi];

module support(text, rotation, support_height, base_height) {
  difference() {
    union() {
      translate([0, 0, base_height / 2])
        cube([10, 10, base_height], center = true);
      translate([0, 0, base_height])
        cylinder(d = 16, h = support_height - 15);
      translate([0, 0, support_height + base_height])
        head(rotation);
    }
    // text coordinates
    translate([-4, -6, 30]) {
      rotate([90, 90, 0]) {
        linear_extrude(2) {
          text(text, 8);
        }
      }
    }
  }
}

module support1(text, rotation, support_height, base_height) {
  difference() {
    union() {
      translate([0, 0, base_height / 2])
        cube([10, 10, base_height], center = true);
      translate([0, 0, base_height])
        cylinder(d = 16, h = support_height - 15);
      translate([0, 0, support_height + base_height])
        head(rotation);
    }
    // text coordinates
    translate([-4, -6, 30]) {
      rotate([90, 90, 0]) {
        linear_extrude(2) {
          text(text, 8);
        }
      }
    }
  }
}

module head(rotation) {
  rotate(rotation) {
    color("orange") {
      difference() {
        sphere(d = 35);
        translate([0, 0, 20])
          cube(40, center = true);
      }
      cylinder(d1 = 15, d2 = 14, h = 4); // CD hole pin
    }
    cd(rotation);
  }
}

module cd(rotation) {
  if (debug) {
    color("grey")
      cylinder(d = 120, h = 1, $fn = 20); // CD
    color("#ff000020")
      rotate([0, rotation[1], 0])
        cylinder(d = 120, h = 1200); // light ray out
    color("red")
      rotate([0, rotation[1], 0])
        cube([1, 1, 1200]); // light ray out
    color("DarkRed")
      rotate([0, -rotation[1], 0])
        cube([1, 1, 1200]); // light ray in
  }
}

module base(base_height, baseDiameter) {
  color("chartreuse")
    difference() {
      union() {
        difference() {
          cylinder(d = baseDiameter, h = base_height, $fn = 6);
          translate([0, 0, -0.001])
            cylinder(d = baseDiameter - 8, h = base_height + 0.002, $fn = 6);
        }
        cylinder(d = 30, h = base_height, $fn = 6);
        translate([0, 0, base_height / 2])
          for(i = [0:2]) {
            rotate([0, 0, 60 * i + 30])
              cube([4, baseDiameter - 3, base_height], center = true);
          }
      }
      cube(10, center = true);
    }
}
