$fn=20;

/* [Animation] */
// rotating animation
animation_rotation = false;

/* for animation */
$vpt = animation_rotation ? [0, 0, 0] : [];
$vpr = animation_rotation ? [70, 0, 365 * $t] : [];
$vpd = animation_rotation ? 500 : [];

pastaCube();

module pastaCube() {
    union() {
        translate([-50, -50, -50]) {
            rotate([0, 0, 0])   pastaWall();
            rotate([90, 0, 0])  pastaWall();
            rotate([0, -90, 0]) pastaWall();

            translate([0, 0, 100]) rotate([0, 0, 0])   pastaWall();
            translate([0, 100, 0]) rotate([90, 0, 0])  pastaWall();
            translate([100, 0, 0]) rotate([0, -90, 0]) pastaWall();
        }
        color("gray") cube([100, 100, 100], center = true);
    }
}

module pastaWall() {
    for (x = [0:4]) {
        for (y = [0:11]) {
            translate([x * 22, y * 8, 0]) {
                //rotate(rands(0, 360, 1)[0])
                pasta();
            }
        }
    }
}

module pasta(R = 10, r = 3, e = 1) {
    translate([8, -4, 0])
        rotate([0, 0, 30])
            difference() {
                rotate_extrude(angle = 120) translate([R, 0, 0]) circle(r);
                rotate_extrude(angle = 220) translate([R, 0, 0]) circle(r - e);
            }
}
