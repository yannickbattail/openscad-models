module mug(height, radius, thickness) {
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
        translate([0, 0, thickness]) {
            cylinder(h = height - thickness + epsi, r = radius - thickness); // + epsi to prevent display bug
        }
    }
}

module handle(height) {
    scale([0.5, 1.2, 0.8]) {
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
