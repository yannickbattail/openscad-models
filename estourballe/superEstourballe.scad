part = "estourballeEntiere"; // [estourballeEntiere, demiSphereBas, demiSpherehaut, anneau, bouton, croix]

/* [Animation] */
// rotating animation
animation_rotation = false;

$fn = 100;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated?[0, 0, 0]:[];
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:[]; // animation rotate around the object
$vpd = is_animated?500:[];

estourballePieces(part);

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
    } else if (part == "croix") {
        crossBase(ballDiameter);
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
    crossBase(ballDiameter);
    crossTop();
}

module halfSphereBottom(ballDiameter, thickness) {
    color("white")
        translate([0, 0, - 1])
            difference() {
                sphere(d = ballDiameter);
                translate([0, 0, ballDiameter / 2])
                    cube(ballDiameter, center = true);
                sphere(d = ballDiameter - thickness);
            }
}

module halfSphereTop(ballDiameter, thickness) {
    translate([0, 0, 1])
        difference() {
            union() {
                color("blue")
                    sphere(d = ballDiameter);
                bande(ballDiameter);
                mirror([0, 1]) {
                    bande(ballDiameter);
                }
            }
            translate([0, 0, - ballDiameter / 2])
                cube(ballDiameter, center = true);
            sphere(d = ballDiameter - thickness);
            crossBase(ballDiameter);
        }
}

module bande(ballDiameter) {
    difference() {
        union() {
            color("red")
                sphere(d = ballDiameter + 4);
            rotate([55, 0, 0])
                nails(ballDiameter);
        }
        rotate([65, 0, 0])
            translate([- ballDiameter / 2 - 2, - ballDiameter / 2 - 2, 0])
                cube(ballDiameter + 4);
        rotate([- 45, 0, 0])
            translate([- ballDiameter / 2 - 2, 0, - ballDiameter / 2 - 2])
                cube(ballDiameter + 4);
        rotate([0, 90, 0])
            cylinder(d = 30, h = ballDiameter + 10, center = true);
    }
}

module nails(ballDiameter) {
    color("white")
        for (i = [0:12]) {
            rotate([0, 0, i * 360 / 12])
                translate([0, ballDiameter / 2 + 1, 0])
                    sphere(d = 5);
        }
}

module ringBlack(ballDiameter, thickness) {
    difference() {
        color("DarkSlateGray")
            cylinder(d = ballDiameter + 3, h = 15, center = true);

        color("DarkSlateGray")
            translate([0, 0, 6])
                difference() {
                    cylinder(d = ballDiameter + 4, h = 1, center = true);
                    cylinder(d = ballDiameter + 2, h = 1, center = true);
                }
        color("DarkSlateGray")
            translate([0, 0, - 6])
                difference() {
                    cylinder(d = ballDiameter + 4, h = 1, center = true);
                    cylinder(d = ballDiameter + 2, h = 1, center = true);
                }
        button(ballDiameter);
        translate([0, 0, 1])
            cylinder(d = ballDiameter, h = ballDiameter);
        translate([0, 0, - ballDiameter - 1])
            cylinder(d = ballDiameter, h = ballDiameter);
        cylinder(d = ballDiameter - 4, h = ballDiameter, center = true);
    }
}

module torus(radius, thickness) {
    rotate_extrude() {
        translate([radius, 0]) circle(r = thickness);
    }
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

module crossBase(ballDiameter) {
    color("red") {
        difference() {
            translate([0, 0, ballDiameter / 2 - 4]) {
                cylinder(d = 26, h = 10);
            }
            translate([0, 0, ballDiameter / 2 + 6])
                torus(12, 6);
        }

    }
}
module crossTop() {
    translate([0, 0, 66]) {
        arm();
        rotate([90, 0, 0])
            arm();
        rotate([- 90, 0, 0])
            arm();
        rotate([180, 0, 0])
            arm();

        color("white")
            scale([0.8, 0.5, 1])
                sphere(8);
    }
}

module arm() {
    translate([5, 0, 0])
        rotate([90, 0, 0])
            rotate([0, - 90, 0]) {
                color("red") {
                    linear_extrude(10) {
                        halfArm();
                        mirror([1, 0]) {
                            halfArm();
                        }
                        translate([0, 30])
                            circle(d = 10);
                    }
                }
                color("white") {
                    translate([0, 10, 1])
                        sphere(d = 4);
                    translate([0, 20, 1])
                        sphere(d = 4);
                    translate([0, 10, 9])
                        sphere(d = 4);
                    translate([0, 20, 9])
                        sphere(d = 4);
                }
            }
}

module halfArm() {
    polygon([[0, 0], [0, 30], [8, 30], [6, 25], [5, 20], [5, 0]]);
}