part = "estourballeEntiere"; // [estourballeEntiere, demiSphereBas, demiSpherehaut, anneau, bouton, croix]

/* [Animation] */
// rotating animation
animation_rotation = false;

$fn = 100;

// cut the mug in quarter and display the nutella glass
debug = false;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated?[0, 0, 0]:[];
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:[]; // animation rotate around the object
$vpd = is_animated?500:[];
if (debug) {
    difference() {
        estourballePieces(part);
        translate([0, 0, - 100]) cube(200);
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
        translate([0, 0, - 0.01])
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
                color("DarkViolet")
                    sphere(d = ballDiameter);
                color("Magenta") {
                    mmirror([0,0,1])
                        rotate([45, 0, 0])
                            scale([0.9, 0.8, 1.1])
                               sphere(d = ballDiameter);
                }
                color("white") {
                    rotate([0,-55,0])
                        translate([ballDiameter / 2-1, 0, 0])
                            sphere(d = 5);
                    rotate([0,-40,0])
                        translate([ballDiameter / 2-1, 0, 0])
                            sphere(d = 4);
                    rotate([0,-30,0])
                        translate([ballDiameter / 2-1, 0, 0])
                            sphere(d = 3);
                }
            }
            translate([0, 0, - ballDiameter / 2 - 1])
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

module nails(ballDiameter) {
    color("white")
    for (i = [0:16]) {
        rotate([0, 0, i * 360 / 16])
            translate([0, ballDiameter / 2, 0])
                sphere(d = 4);
    }
}

module ringBlack(ballDiameter, thickness) {
    difference() {
        color("SlateGray")
            cylinder(d = ballDiameter + 3, h = 7, center = true);
        button(ballDiameter);
        translate([0, 0, 1])
            cylinder(d = ballDiameter, h = ballDiameter);
        translate([0, 0, - ballDiameter - 1])
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
        rotate([- 90, 0, 0])
            arm();
        crossBase();

        mmirror([0, 0, 1])
        mmirror([1, 0, 0])
        mmirror([0, 1, 0]) {
            crosMidle();
        }
    }
}

module crosMidle() {
    color("white")
    translate([5.001,0,0])
    difference() {
        cube(15);
        translate([18.5,13,11])
           sphere(23);
    }
}

module crossBase() {
    translate([0, 0, - 35 / 2]) {
        color("DarkViolet") {
            cube([10, 10, 35], center = true);
            translate([5, 0, 0])
                rotate([0, -90, 0])
                    linear_extrude(10) {
                        mmirror([0, 1]) {
                            crossFoot();
                        }
                    }
        }
        color("white") {
            translate([5, 0, -8])
                sphere(d = 3);
            translate([-5, 0, -8])
                sphere(d = 3);
        }
    }
}

module crossFoot() {
    polygon([[- 14, 5],
            [- 15, 8],
            [- 12, 8],
            [- 7, 5]]);
}

module arm() {
    translate([5, 0, 0])
        rotate([90, 0, 0])
            rotate([0, - 90, 0]) {
                color("DarkViolet") {
                    linear_extrude(10) {
                        mmirror([1, 0]) {
                            halfArm();
                        }
                    }
                }
                color("white") {
                    translate([0, 28, 1])
                        sphere(d = 3);
                    translate([0, 28, 9])
                        sphere(d = 3);
                }
            }
}

module halfArm() {
    polygon([[0, 0],
            [0, 31],
            [2, 31],
            [2.5, 29],
            [4, 27],
            [7, 26],
            [5, 22],
            [5, 8],
            [8, 0]]);
}

/*
same as mirror but duplicate children
*/
module mmirror(mat) {
    children();
    mirror(mat)
        children();
}
