module bend(Angle, _big_value = 1000) {
    angle = Angle % 180;
    bendStart(angle, _big_value) children(0);
    bentPart(angle, _big_value) children(0);
    bendEnd(angle, _big_value) children(0);
}

module bentPart(angle, _big_value) {
    signe = angle > 0?1:-1;
    rotate([90, 0, 0])
        rotate_extrude(angle = angle)
            difference() {
                projection()
                    children(0);
                translate([-signe * _big_value / 2, 0])
                    square(_big_value, center = true);
            }
}

module bendStart(angle, _big_value) {
    difference() {
        children(0);
        translate([0, 0, _big_value / 2])
            cube(_big_value, center = true);
        rotate([0, -angle / 2, 0])
            translate([0, 0, _big_value / 2])
                cube(_big_value, center = true);
    }
}

module bendEnd(angle, _big_value) {
    rotate([0, -angle, 0])
        difference() {
            children(0);
            translate([0, 0, -_big_value / 2])
                cube(_big_value, center = true);
            rotate([0, angle / 2, 0])
                translate([0, 0, -_big_value / 2])
                    cube(_big_value, center = true);
        }
}
