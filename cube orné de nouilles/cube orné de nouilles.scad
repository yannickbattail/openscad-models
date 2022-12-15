
$fn=20;
c=100;
union() {
    every_faces=[
            [0,   0, 0  ], // top
            //[180, 0, 0  ], // bottom
            [90,  0, 0  ], // front 
            [-90, 0, 0  ], // back
            [90,  0, 90 ], // right
            [90,  0, -90]  // left
        ];
    for (i = every_faces) {
        rotate(i) translate([0,0,c/2]) pastaWall();
    }
    color("gray") cube([c, c, c], center = true);
}
module pastaWall() {
    for (x = [-2:2]) {
        for (y = [-6:4]) {
            translate([x * 22, y * 8, 0]) {
                //rotate(rands(0, 360, 1)[0])
                pasta();
            }
        }
    }
}

module pasta(R = 10, r = 3, e = 1) {
    rotate([0, 0, 30]) {
        difference() {
            rotate_extrude(angle = 120) translate([R, 0, 0]) circle(r);
            rotate_extrude(angle = 220) translate([R, 0, 0]) circle(r - e);
        }
    }
}