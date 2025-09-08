part = "estourballeEntiere"; // [estourballeEntiere, demiSphereBas, demiSpherehaut, anneau, bouton, bande1, bande2, croix]

/* [Animation] */
// rotating animation
animation_rotation = false;

$fn = 100;

// cut the mug in quarter and display the nutella glass
debug = false;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated ? [0, 0, 0] : [];
$vpr = is_animated ? [60, 0, animation_rotation ? (365 * $t) : 45] : []; // animation rotate around the object
$vpd = is_animated ? 500 : [];
if (debug) {
  difference() {
    estourballePieces(part);
    translate([0, 0, -100])
      cube(200);
  }
} else {
  estourballePieces(part);
}

module estourballePieces(part) {
  ballDiameter = 70;
  thickness = 5;
  if (part == "demiSphereBas") {
    halfSphereBottom(ballDiameter, thickness);
  } else if (part == "demiSpherehaut") {
    halfSphereTop(ballDiameter, thickness);
  } else if (part == "anneau") {
    ringBlack(ballDiameter, thickness);
  } else if (part == "bouton") {
    button(ballDiameter);
  } else if (part == "bande1") {
    bande1(ballDiameter, thickness);
  } else if (part == "bande2") {
    bande2(ballDiameter, thickness);
  } else if (part == "croix") {
    crossTop();
  } else {
    estourballe(ballDiameter, thickness);
  }
}

module estourballe(ballDiameter, thickness) {
  halfSphereTop(ballDiameter, thickness);
  halfSphereBottom(ballDiameter, thickness);
  ringBlack(ballDiameter, thickness);
  button(ballDiameter);
  bandes(ballDiameter, thickness);
  crossTop();
}

module halfSphereBottom(ballDiameter, thickness) {
  color("white")
    translate([0, 0, -0.01])
      difference() {
        sphere(d = ballDiameter);
        translate([0, 0, ballDiameter / 2 + 1])
          cube(ballDiameter, center = true);
        sphere(d = ballDiameter - thickness);
      }
}

module halfSphereTop(ballDiameter, thickness) {
  translate([0, 0, 0.01]) {
    difference() {
      union() {
        color("DarkSlateGray")
          sphere(d = ballDiameter);
      }
      translate([0, 0, -ballDiameter / 2 - 1])
        cube(ballDiameter, center = true);
      sphere(d = ballDiameter - thickness);
      crossTop();
    }
  }
}

module bandes(ballDiameter, thickness) {
  bande1(ballDiameter, thickness);
  bande2(ballDiameter, thickness);
}

module bande1(ballDiameter, thickness) {
  difference() {
    union() {
      color("gold")
        sphere(d = ballDiameter + 2);
      nailsBande(ballDiameter);
    }
    sphere(d = ballDiameter + 0.1);
    translate([0, 0, -(ballDiameter + 10) / 2 + 5.5])
      cube(ballDiameter + 10, center = true);
    translate([0, -(ballDiameter + 10) / 2 - 22, 0])
      cube(ballDiameter + 10, center = true);
    // translate([0, (ballDiameter + 10) / 2 + 22, 0])
    //     #cube(ballDiameter+10, center = true);
    translate([22, 0, 0])
      cube([32, 28, ballDiameter + 10], center = true);
    translate([-22, 0, 0])
      cube([32, 28, ballDiameter + 10], center = true);
    cube([10, 10, 100], center = true);
    cube([8, 20, 100], center = true);
    translate([-(ballDiameter + 10) / 2, 0, 0]) {
      cube(ballDiameter + 10);
    }
  }
}

module bande2(ballDiameter, thickness) {
  mirror([0, 1, 0]) {
    bande1(ballDiameter, thickness);
  }
}

module nailsBande(ballDiameter) {
  color("white")
    for(i = [1:5]) {
      rotate([0, i * 360 / 12 - 90, 0])
        translate([0, -18, 30])
          sphere(d = 5);
    }
}

module nails(ballDiameter) {
  color("white") {
    for(i = [0:2]) {
      rotate([0, 0, (i - 1) * 40])
        translate([0, ballDiameter / 2 + 1, 0])
          sphere(d = 5);
    }
    for(i = [0:2]) {
      rotate([0, 0, (i - 1) * 40 + 180])
        translate([0, ballDiameter / 2 + 1, 0])
          sphere(d = 5);
    }
  }
}

module ringBlack(ballDiameter, thickness) {
  difference() {
    color("SlateGray")
      cylinder(d = ballDiameter + 3, h = 11, center = true);
    button(ballDiameter);
    translate([0, 0, 1])
      cylinder(d = ballDiameter, h = ballDiameter);
    translate([0, 0, -ballDiameter - 1])
      cylinder(d = ballDiameter, h = ballDiameter);
    cylinder(d = ballDiameter - 4, h = ballDiameter, center = true);
  }
  nails(ballDiameter);
}

module button(ballDiameter) {
  color("white")
    rotate([0, 90, 0]) {
      translate([0, 0, ballDiameter / 2 + 0.2]) {
        cylinder(d = 13, h = 2);
        cylinder(d = 6, h = 3);
      }
    }
}

module crossTop() {
  translate([0, 0, 66]) {
    arm();
    rotate([90, 0, 0])
      arm();
    rotate([-90, 0, 0])
      arm();
    crossBase();

    color("white")
      scale([0.8, 0.5, 1])
        sphere(8);
  }
}

module crossBase() {
  translate([0, 0, -35 / 2])
    color("gold") {
      cube([10, 10, 35], center = true);
      translate([4, 0, 0])
        rotate([0, -90, 0])
          linear_extrude(8) {
            crossFoot();
            mirror([0, 1]) {
              crossFoot();
            }
          }
    }
}

module crossFoot() {
  polygon([
    [-14, 5],
    [-15, 10],
    [-8, 7],
    [-5, 9],
    [-3, 5]
  ]);
}

module arm() {
  translate([5, 0, 0])
    rotate([90, 0, 0])
      rotate([0, -90, 0]) {
        color("gold") {
          linear_extrude(10) {
            halfArm();
            mirror([1, 0]) {
              halfArm();
            }
          }
        }
        color("white") {
          translate([0, 10, 1])
            sphere(d = 4);
          translate([0, 10, 9])
            sphere(d = 4);
          translate([0, 30, 5])
            scale([0.8, 0.5, 1])
              sphere(7);
        }
      }
}

module halfArm() {
  polygon([
    [0, 0],
    [0, 37],
    [7, 30],
    [6, 25],
    [5, 20],
    [5, 0]
  ]);
}
