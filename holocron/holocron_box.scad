// part to generate
part = "all"; // [all, all_faces, face, face_side,  box_top, box_bottom]

// size of the model
box_thickness = 0.8; // [0.1:0.1:3]

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated?[0, 0, 0]:$vpt;
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:$vpr;  // animation rotate around the object
$vpd = is_animated?500:$vpd;
$fn = 100;
epsi = 0.01;
// size of the model
thickness = 8; // [10:5:100]

if (part == "face") {
    face(thickness);
} else if (part == "face_side") {
    face_side(thickness);
} else if (part == "all_faces") {
    all_faces(thickness);
} else if (part == "box_top") {
    box_top(box_thickness);
} else if (part == "box_bottom") {
    box_bottom(box_thickness);
} else {
    all_faces(thickness);
    box_top(box_thickness);
    box_bottom(box_thickness);
}

module box_top(box_thickness) {
    color("blue")
        difference() {
            box(box_thickness);
            translate([0, 0, -25])
                cube(100 + epsi, center = true);
        }
}

module box_bottom(box_thickness) {
    color("blue")
        difference() {
            box(box_thickness);
            translate([0, 0, 75])
                cube(100 + epsi, center = true);
        }
}
module box(box_thickness) {
    box_size = 100 - 0.1;
    difference() {
        cube(box_size, center = true);
        cube(box_size - box_thickness * 2, center = true);
    }
}

module all_faces(thickness) {
    // top
    translate([0, 0, 50])
        face(thickness);
    // bottom
    translate([0, 0, -50])
        rotate([180, 0, 0])
            face(thickness);

    // front
    rotate([90, 0, 0])
        translate([0, 0, 50])
            face_side(thickness);
    // back
    rotate([90, 0, 180])
        translate([0, 0, 50])
            face_side(thickness);
    // right
    rotate([90, 0, 90])
        translate([0, 0, 50])
            face_side(thickness);
    // left
    rotate([90, 0, -90])
        translate([0, 0, 50])
            face_side(thickness);
}

module face_side(thickness) {
    difference() {
        face(thickness);
        translate([100, 0, 0])
            cube([100, 100 + thickness, 100] * (1 + epsi), center = true);
        translate([0, 100, 0])
            cube([100 + thickness, 100, 100] * (1 + epsi), center = true);
        translate([0, -100, 0])
            cube([100 + thickness, 100, 100] * (1 + epsi), center = true);
    }
}

module face(thickness) {
    linear_extrude(thickness / 2)
        holocronFace2D_1(thickness);
    linear_extrude(thickness / 4)
        holocronFace2D_2(thickness);
    color("red")
        linear_extrude(1)
            holocronFace2D_holder(thickness);
}

module holocronFace2D_1(thickness) {
    difference() {
        square([100 + thickness, 100 + thickness], center = true);
        square([100, 100], center = true);
    }
    hypo = (100 + thickness) / 2 * sqrt(2);
    rotate([0, 0, 45]) {
        difference() {
            square([hypo, hypo], center = true);
            square([hypo - thickness, hypo - thickness], center = true);
        }
    }
}

module holocronFace2D_2(thickness) {
    difference() {
        circle(d = 100 + thickness / 2 - 2);
        circle(d = 100 - 2);
    }
    hypo = (100 + thickness) / 2 * sqrt(2);
    rotate([0, 0, 45]) {
        difference() {
            square([50 + thickness / 2, 50 + thickness / 2], center = true);
            square([50 - 1, 50 - 1], center = true);
        }
    }
    difference() {
        circle(d = 50);
        circle(d = 50 - thickness / 2);
    }
}

module holocronFace2D_holder(thickness) {
    difference() {
        union() {
            square([1, 100], center = true);
            square([100, 1], center = true);
        }
        rotate([0, 0, 45])
            square([50 + thickness / 2, 50 + thickness / 2], center = true);
    }
}
