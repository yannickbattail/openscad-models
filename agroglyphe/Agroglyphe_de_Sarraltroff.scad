$fn=100;

translate([0, - 2, - 4]) rotate([90, 0, 0]) ring(6, 2);

scale(0.02) agroglyphe_pendantif();

module agroglyphe_pendantif() {
    barre=80;
    translate([-barre/2, -barre, 0]) cube([barre, barre, 3400]);
    agroglyphe_rotation();
}

module agroglyphe_rotation() {
    rotate_extrude(angle = 90) {
        difference() {
            rotate([0, 0, 90]) agroglyphe();
            square(4000);
        }
    }

    rotate_extrude(angle = - 90) {
        difference() {
            rotate([0, 0, 90]) agroglyphe();
            translate([- 4000, 0]) square(4000);
        }
    }
}

module agroglyphe() {
    // taille en pixel depuis la photo
    r1 = 10;
    r2 = 50;
    r3 = 150;
    r4 = 250;
    r5 = 3 * r4 + 2 * r3;
    r6 = 2 * r4 + 2 * r3;
    r7 = r4 + 2 * r3;
    r8 = r4 + r3;

    translate([r1, 0]) circle(r = r1);
    translate([r1 * 2, 0]) {
        translate([r2, 0]) circle(r = r2);
        translate([r2 * 2, 0]) {
            translate([r3, 0]) circle(r = r3);
            translate([r3 * 2, 0]) {
                translate([r5, 0]) {
                    color("red") circle(r = 10);
                    goutte(r5, r6, true, true);
                    goutte(r5, r6, false, false);
                    goutte(r7, r8, true, false);
                    goutte(r7, r8, false, true);
                    circle(r = r4);
                    translate([r5 - 2 * r4 + r6, 0]) {
                        goutte(r6, r7, true, false);
                    }
                }
                translate([r5 * 2, 0]) {
                    translate([r4, 0]) circle(r = r4);
                    translate([r4 * 2, 0]) {
                        translate([r3, 0]) circle(r = r3);
                        translate([r3 * 2, 0]) {
                            translate([r2, 0]) circle(r = r2);
                            translate([r2 * 2, 0]) {
                                translate([r1, 0]) circle(r = r1);
                            }
                        }
                    }
                }
            }
        }
    }
}

module goutte(r_ext, r_int, droite, haut) {
    r_cercle=r_ext-r_int;
    // goutte 1
        difference() {
            circle(r = r_ext);
            translate([0, r_ext*(haut?-1:1)]) square(r_ext * 2, center = true);
            translate([r_cercle*(droite?1:-1), 0]) circle(r = r_int);
        }
    translate([r_int*(droite?-1:1), 0]) {
        circle(r = r_cercle);
    }
}


module ring(diameter, radius) {
    rotate_extrude()
        translate([diameter, 0, 0])
            circle(r = radius);

}