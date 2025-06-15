// piece
part = "octogonal"; // [rond, carre, octogonal, jeton, corner]
element = "red"; // [red:feu, yellow:air, green:terre, blue:eau, DarkSlateGray:noir, white:blanc, gray:gris]

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
$vpt = is_animated?[0, 0, 0]:$vpt;
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:$vpr;  // animation rotate around the object
$vpd = is_animated?200:$vpd;
// constant epsilon
EPSI = 0.001;

color(element) {
  if (part == "rond") {
    rond(width, thickness, tolerence, cavity);
  } else if (part == "carre") {
    carre(width, thickness, tolerence, cavity);
  } else if (part == "octogonal") {
    octogonal(width, thickness, tolerence, cavity);
  } else if (part == "jeton") {
    jeton(width, thickness, tolerence, cavity);
  } else if (part == "corner") {
    corner(width, thickness, tolerence, cavity);
  } else {
    assert(false, "unknown part");
  }
}

module rond(width, thickness, tolerence, cavity) {
  difference() {
    cylinder(d = width, h = thickness, center = true);
    holes(thickness);
    deplacementRond(width, thickness, tolerence, cavity);
    elementIcon(width, thickness, tolerence, cavity);
  }
}

module deplacementRond(width, thickness, tolerence, cavity) {
  remainingSpace = (width - cavity) / 2;
  margingPercent = 0.1; // 10% of the remaining space
  size = remainingSpace - remainingSpace * margingPercent * 2;
  iconDepth = thickness * 0.05;
  translate([cavity / 2 + remainingSpace / 2, 0, thickness / 2 - iconDepth + EPSI]) {
    linear_extrude(iconDepth) {
      translate([size / 3, size / 3]) square(size / 3 * 0.9, center = true);
      translate([size / 3, -size / 3]) square(size / 3 * 0.9, center = true);
      translate([-size / 3, size / 3]) square(size / 3 * 0.9, center = true);
      translate([-size / 3, -size / 3]) square(size / 3 * 0.9, center = true);
    }
  }
}

module carre(width, thickness, tolerence, cavity) {
  difference() {
    cube([width, width, thickness], center = true);
    holes(thickness);
    deplacementCarre(width, thickness, tolerence, cavity);
    elementIcon(width, thickness, tolerence, cavity);
  }
}

module deplacementCarre(width, thickness, tolerence, cavity) {
  remainingSpace = (width - cavity) / 2;
  margingPercent = 0.1; // 10% of the remaining space
  size = remainingSpace - remainingSpace * margingPercent * 2;
  iconDepth = thickness * 0.05;
  translate([cavity / 2 + remainingSpace / 2, 0, thickness / 2 - iconDepth + EPSI]) {
    linear_extrude(iconDepth) {
      translate([0, size / 3]) square(size / 3 * 0.9, center = true);
      translate([0, -size / 3]) square(size / 3 * 0.9, center = true);
      translate([size / 3, 0]) square(size / 3 * 0.9, center = true);
      translate([-size / 3, 0]) square(size / 3 * 0.9, center = true);
    }
  }
}

module octogonal(width, thickness, tolerence, cavity) {
  difference() {
    intersection() {
      cube([width, width, thickness], center = true);
      rotate([0, 0, 45])
        cube([width, width, thickness], center = true);
    }
    holes(thickness);
    deplacementCarre(width, thickness, tolerence, cavity);
    deplacementRond(width, thickness, tolerence, cavity);
    elementIcon(width, thickness, tolerence, cavity);
  }
}

module jeton(width, thickness, tolerence, cavity) {
  cylinder(d = cavity - tolerence, h = thickness * 4 / 5 - tolerence, center = true);
}

module corner(width, thickness, tolerence, cavity) {
  difference() {
    cube([width, width, thickness], center = true);
    translate([EPSI, EPSI, -thickness / 2 - EPSI])
      cube([width / 2, width / 2, thickness + EPSI * 2]);
  }
}

module holes(thickness) {
  cavity_depth = 2 / 5 * thickness;
  translate([0, 0, (thickness - cavity_depth) / 2 + EPSI])
    cylinder(d = cavity, h = cavity_depth + 2 * EPSI, center = true);
  translate([0, 0, -(thickness - cavity_depth) / 2 - EPSI])
    cylinder(d = cavity, h = cavity_depth + 2 * EPSI, center = true);
}

module elementIcon(width, thickness, tolerence, cavity) {
  remainingSpace = (width - cavity) / 2;
  margingPercent = 0.1; // 10% of the remaining space
  size = remainingSpace - remainingSpace * margingPercent * 2;
  iconDepth = thickness * 0.05;
  translate([-cavity / 2 - remainingSpace / 2, 0, thickness / 2 - iconDepth + EPSI]) {
    linear_extrude(iconDepth) {
      elementImage(element, size);
    }
  }
  elementIconEdge(width, thickness, tolerence, cavity);
}

module elementIconEdge(width, thickness, tolerence, cavity) {
  iconDepth = thickness * 0.05;
  for (i = [0:3]) {
    angle = i * 90;
    rotate([0, 0, angle]) {
      translate([0, width / 2 + EPSI, 0]) {
        rotate([90, 0, 0]) {
          linear_extrude(iconDepth) {
            elementImage(element, thickness);
          }
        }
      }
    }
  }
}

module elementImage(element, size) {
  scale(size / 256) {
    if (element == "red") {
      import("./icons/feu.svg", center = true);
    } else if (element == "yellow") {
      import("./icons/air.svg", center = true);
    } else if (element == "green") {
      import("./icons/terre.svg", center = true);
    } else if (element == "blue") {
      import("./icons/eau.svg", center = true);
    } else {
      square(0);
    }
  }
}
