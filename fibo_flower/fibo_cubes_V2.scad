// Global Variables
$fn = 100;
PI = 3.14159;
GOLDANGLE = 137.51;
SDIAM = 90;//SDIAM=100;
SRADI = 45;//SDIAM=50
//CDIAM=150;
//CRADI=(150/2);
CIRCUM = PI * SDIAM;
$vpt = [0, 0, 0];
$vpr = [60, 0, ((144 * $t) * - GOLDANGLE) % 360];
$vpd = 400;
TRYCOLOR = "GREY";

module element() {
    //    cube(10,center=true);
    cylinder(h = 10, r1 = 10, r2 = 0, center = false);
}


module holsphr() {
    difference() {
        sphere(d = SDIAM);
        sphere(d = SDIAM - 5);
    }
}

module elements() {
    for (loop = [0:200]) {
        rotate([0, 0, - (GOLDANGLE * loop)])
            rotate([0, loop / 2, 0])
                translate([0, 0, SRADI])
                    rotate([0, loop, 0])
                        element();
    }
}
elements();

/* Half-Ball of squares */
color(TRYCOLOR)difference() {
    difference() {
        union() {
            sphere(d = SDIAM);
            elements();
        };
        sphere(d = SDIAM - 10);
    }
    translate([0, 0, - SRADI - 17])
        cube(SDIAM + 35, center = true);
}

/* Base */
color(TRYCOLOR)difference() {
    cylinder(h = 5, r = SRADI + 15, center = true);
    translate([0, 0, - 1])
        cylinder(h = 14, r = SRADI, center = true);
}
color(TRYCOLOR)difference() {
    union() {
        cube([SDIAM, 5, 5], center = true);
        cube([5, SDIAM, 5], center = true);
        cylinder(h = 5, r = 10, center = true);
    }
    cylinder(h = 10, r = 3.75, center = true);
}

