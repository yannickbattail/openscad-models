$fn=50;
tardis();
module tardis() {
    union() {
            translate([0, 0, 121]) cylinder(h = 3, r1 = 3.5, r2 = 0);
            translate([0, 0, 115]) cylinder(h = 6, r = 3);
            translate([0, 0, 110]) linear_extrude(6, scale = 0) square(30, center = true);
            translate([0, 0, 107.5]) cube([30, 30, 5], center = true);
            translate([0, 0, 102.5]) cube([40, 40, 5], center = true);
            //translate([0, 0, 50]) cube([50, 50, 100], center = true);
    }
    face();
}

module face() {
	translate([25, 0, 0]) {
    difference() {
            #translate([-4, -25, 0]) cube([4, 50, 100]);
            translate([-3, -20, 5]) cube([4, 40, 90]);
        }
        c=2;
        translate([c/2, 0, 100-c*2]) cube([c, 46, c*4], center=true);
        difference() {
			
			translate([25, 0, 10]) cube([c, 46, c * 4], center = true);
		}
    }
}
