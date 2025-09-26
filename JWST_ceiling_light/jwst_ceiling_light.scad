part = "all"; // [all, support]

// distance of the focus point of innter cells
focus_distance_inner = 1200; // [100:2000]
// distance of the focus point of outer cells
focus_distance_outer = 800; // [100:2000]

// support height (from the bottom of the base)
support_height = 10; // [35:100]

// add the mirrors to the display
show_mirrors = true;

// display CD, light rays, focus point and coordinates
debug = true;

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [hidden] */
$fn = 100;

$vpt = animation_rotation ? [0, 0, 500] : [];
$vpr = animation_rotation ? [70, 0, 365 * $t] : [];
$vpd = animation_rotation ? 3500 : [];

// constants
number_of_rows = 9; // [1:1:40]
number_of_column = 3; // [1:1:40]
baseSide = 120;
baseDiameter = baseSide / (sqrt(3) / 2);
baseRadius = baseDiameter / 2;
EPSI = 0.01;
dimentions = [positionX(number_of_column, number_of_rows), positionY(number_of_column, number_of_rows)];

if (part == "all" || part == "support") {
  solar_oven(support_height, baseDiameter);
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

module solar_oven(support_height, baseDiameter) {
  cellRing(innerCells, focus_distance_inner, support_height, baseDiameter);
  cellRing(outerCells, focus_distance_outer, support_height, baseDiameter);
}

module cellRing(cells, focus_distance, support_height, baseDiameter) {
  focusPos = [0, 0, focus_distance];
  focusPoint(debug, focusPos);
  for(i = [0:len(cells) - 1]) {
    c = cells[i];
    cell(c[0], c[1], focusPos, support_height, baseDiameter);
  }
}

module cell(x, y, focusPos, support_height, baseDiameter) {
  xt = positionX(x, y);
  yt = positionY(x, y);
  if (part == "all" || (part == "support")) {
    supportRotation = support_rotation(focusPos, [xt, yt, support_height]);
    translate([xt, yt, 0]) {
      support(supportRotation, support_height);
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

module support(rotation, support_height) {
  color("DarkSlateGray")
    difference() {
      cylinder(d = 140, h = support_height + 40, $fn = 6);
      translate([0, 0, support_height]) {
        rotate(rotation) {
          translate([0, 0, 100])
            cube(200, center = true);
        }
      }
    }
  translate([0, 0, support_height]) {
    rotate(rotation) {
      hexMirror(rotation);
    }
  }
}

module hexMirror(rotation) {
  if (show_mirrors) {
    color("gold")
      rotate([0, 0, -rotation[2]])
        cylinder(d = 130, h = 1, $fn = 6); // the mirror
  }
  if (debug) {
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
