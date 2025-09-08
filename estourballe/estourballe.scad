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
        halfSphereWhite(ballDiameter, thickness);
    } else if (part == "demiSpherehaut") {
        halfSphereRed(ballDiameter, thickness);
    } else if (part == "anneau") {
        ringBlack(ballDiameter, thickness);
    } else if (part == "bouton") {
        rotate([0,-90,0]) {
            button(ballDiameter);
        }
    } else if (part == "croix") {
        crossBase(ballDiameter);
        crossWhite();
    } else {
        estourballe(ballDiameter, thickness);
    }
}

module estourballe(ballDiameter, thickness) {
    halfSphereRed(ballDiameter, thickness);
    halfSphereWhite(ballDiameter, thickness);
    ringBlack(ballDiameter, thickness);
    button(ballDiameter);
    crossBase(ballDiameter);
    crossWhite();
}

module halfSphereWhite(ballDiameter, thickness) {
    color("white")
        translate([0, 0, -1])
            difference() {
                sphere(d = ballDiameter);
                translate([0, 0, ballDiameter / 2])
                    cube(ballDiameter, center = true);
            sphere(d = ballDiameter-thickness);
            }
}

module halfSphereRed(ballDiameter, thickness) {
    color("red")
        translate([0, 0, 1])
            difference() {
                sphere(d = ballDiameter);
                translate([0, 0, - ballDiameter / 2])
                    cube(ballDiameter, center = true);
            sphere(d = ballDiameter-thickness);
            crossBase(ballDiameter);
            }
}

module ringBlack(ballDiameter, thickness) {
    difference() {
        union() {
            color("DarkSlateGray")
            scale([1, 1, 3]) {
                torus(ballDiameter / 2, 2);
            }
            nails(ballDiameter);
        }
        button(ballDiameter);
        translate([0,0,1])
            cylinder(d=ballDiameter, h=ballDiameter);
        translate([0,0,-ballDiameter-1])
            cylinder(d=ballDiameter, h=ballDiameter);
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
            translate([0,0,ballDiameter/2+0.2]) {
                cylinder(d = 13, h = 2);
                cylinder(d = 6, h = 3);
            }
        }
}

module nails(ballDiameter) {
    color("white")
        for (i = [0:12]) {
            rotate([0, 0, i * 360 / 12])
                translate([0, ballDiameter / 2, 0])
                    sphere(d = 5);
        }
}

module crossBase(ballDiameter) {
    color("white") {
        difference() {
            translate([0,0,ballDiameter/2 -4]) {
                cylinder(d = 26, h = 10);
            }   
            translate([0, 0, ballDiameter / 2 + 6])
                torus(12, 6);
        }

    }
}

module crossWhite() {
    translate([0, 0, 66]) {
        arm();
        rotate([90, 0, 0])
            arm();
        rotate([- 90, 0, 0])
            arm();
        rotate([180, 0, 0])
            arm();
        color("red")
            sphere(d = 13);
    }
}

module arm() {
    color("white")
        linear_extrude(30, scale = 1.3) {
            square(10, center = true);
        }
    color("red")
        translate([0, 13, 0])
            sphere(d = 12);
}
