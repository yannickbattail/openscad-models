module mug(height, radius, thickness, full = false) {
    epsi = 0.01; // epsilon
    difference() {
        union() {
            cylinder(h = height, r = radius);
            // rounded top
            translate([0, 0, height]) {
                torus(radius - thickness / 2, thickness / 2);
            }
            translate([radius * 1.2, 0, height / 2]) {
                handle(height);
            }
        }
        if (!full) {
            translate([0, 0, thickness]) {
                cylinder(h = height - thickness + epsi, r = radius - thickness); // + epsi to prevent display bug
            }
        }
    }
}

module handle(height) {
    scale([0.4, 1.2, 0.65]) {
        rotate([90, 0, 0]) {
            torus(height / 2, 8);
        }
    }
}

module torus(radius, thickness) {
    rotate_extrude() {
        translate([radius, 0]) circle(r = thickness);
    }
}
