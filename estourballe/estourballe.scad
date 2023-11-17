/* [Animation] */
// rotating animation
animation_rotation = false;

$fn = 100;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated?[0, 0, 0]:[];
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:[]; // animation rotate around the object
$vpd = is_animated?500:[];

estourballe(70);

module estourballe(ballDiameter) {
    translate([0, 0, 0.01])
        halfSphereRed(ballDiameter);
    halfSphereWhite(ballDiameter);
    ringBlack(ballDiameter);
    button(ballDiameter);
    nails(ballDiameter);
    crossBase(ballDiameter);
    crossWhite();
}

module halfSphereWhite(ballDiameter) {
    color("white")
        difference() {
            sphere(d = ballDiameter);
            translate([0, 0, ballDiameter / 2])
                cube(ballDiameter, center = true);
        }
}

module halfSphereRed(ballDiameter) {
    color("red")
        difference() {
            sphere(d = ballDiameter);
            translate([0, 0, - ballDiameter / 2])
                cube(ballDiameter, center = true);
        }
}

module ringBlack(ballDiameter) {
    color("DarkSlateGray")
        scale([1, 1, 3]) {
            torus(ballDiameter / 2, 2);
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
            cylinder(d = 13, h = ballDiameter / 2 + 2);
            cylinder(d = 6, h = ballDiameter / 2 + 3);
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
            cylinder(d = 26, h = ballDiameter / 2 + 6);
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
