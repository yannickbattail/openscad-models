part = "all"; // [all, base, support]

// distance of the focus point of innter cells
focus_distance_inner = 1200; // [100:2000]
// distance of the focus point of outer cells
focus_distance_outer = 800; // [100:2000]

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
number_of_rows = 9; // [1:1:40]
number_of_column = 3; // [1:1:40]
baseSide = 120;
baseDiameter = baseSide / (sqrt(3) / 2);
baseRadius = baseDiameter / 2;
EPSI = 0.01;
dimentions = [positionX(number_of_column, number_of_rows), positionY(number_of_column, number_of_rows)];

if (part == "all" || part == "support") {
  solar_oven(base_height, support_height, baseDiameter);
} else if (part == "base") {
  base(base_height, baseDiameter);
}

innerCells = [
  [0, 2],
  [0, 1],
  [0, -1],
  [0, -2],
  [-1, -1],
  [-1, 1],
];
outerCells = [
  [0, 4],
  [0, 3],
  [1, 2],
  [1, 0],
  [1, -2],
  [0, -3],
  [0, -4],
  [-1, -3],
  [-1, -2],
  [-1, 0],
  [-1, 2],
  [-1, 3],
];

module solar_oven(base_height, support_height, baseDiameter) {
  cellRing(innerCells, focus_distance_inner, base_height, support_height, baseDiameter);
  cellRing(outerCells, focus_distance_outer, base_height, support_height, baseDiameter);
}

module cellRing(cells, focus_distance, base_height, support_height, baseDiameter) {
  focusPos = [0, 0, focus_distance];
  focusPoint(debug, focusPos);
  for(i = [0:len(cells) - 1]) {
    c = cells[i];
    cell(c[0], c[1], focusPos, base_height, support_height, baseDiameter);
  }
}

module cell(x, y, focusPos, base_height, support_height, baseDiameter) {
  xt = positionX(x, y);
  yt = positionY(x, y);
  if (part == "all" || (part == "support")) {
    supportRotation = support_rotation(focusPos, [xt, yt, support_height]);
    translate([xt, yt, 0]) {
      if (show_base && part == "all") {
        base(base_height, baseDiameter);
      }
      support(supportRotation, support_height, base_height);
    }
  }
}

function positionX(x, y) =
  y % 2 ? x * baseRadius * 3 + baseRadius * 1.5 : x * baseRadius * 3;
function positionY(x, y) =
  y * baseSide / 2;

function support_rotation(focusPos, support) =
  let (vect = focusPos - support, sphrCord = sphericalCoord(vect))
    [0, sphrCord[1] / 2, sphrCord[2]];

function sphericalCoord(vect) =
  let (length = norm([vect[0], vect[1], vect[2]]), // radial distance
  theta = acos(vect[2] / length), // inclination angle
  phi = atan2(vect[1], vect[0]) // azimuthal angle
  )
    [length, theta, phi];

module focusPoint(debug, focusPos) {
  if (debug) {
    color("lightyellow")
      translate(focusPos)
        sphere(10); // display focus point
  }
}

module support(rotation, support_height, base_height) {
  difference() {
    union() {
      translate([0, 0, base_height / 2])
        cube([10, 10, base_height], center = true);
      translate([0, 0, base_height])
        cylinder(d = 16, h = support_height - 15);
      translate([0, 0, support_height + base_height])
        head(rotation);
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
    color("gold")
      rotate([0, 0, -rotation[2]])
        cylinder(d = 120, h = 1, $fn = 6); // CD
    //    color("#ff000020")
    //      rotate([0, rotation[1], 0])
    //        cylinder(d = 120, h = 1200); // light ray out
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
          translate([0, 0, -EPSI])
            cylinder(d = baseDiameter - 8, h = base_height + EPSI * 2, $fn = 6);
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
