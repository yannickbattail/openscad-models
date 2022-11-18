$fn=50;

agroglyphe_pendantif();

module agroglyphe_pendantif() {
    barre=8;
    translate([0, - 2, - 4]) rotate([90, 0, 0]) ring(6, 2);
    translate([-barre/2, -barre, 0]) cube([barre, barre, 307]);
    agroglyphe_rotation();
}

module agroglyphe_rotation() {
    rotate_extrude(angle = 90) {
        difference() {
            rotate([0, 0, 90]) agroglyphe2D();
            square(4000);
        }
    }
    rotate_extrude(angle = - 90) {
        difference() {
            rotate([0, 0, 90]) agroglyphe2D();
            translate([- 4000, 0]) square(4000);
        }
    }
}

module agroglyphe2D() {
    translate([0, -95]) {
        import("Agroglyphe_de_Sarraltroff.svg");
    }
}

module ring(diameter, radius) {
    rotate_extrude()
        translate([diameter, 0, 0])
            circle(r = radius);

}