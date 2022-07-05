$fn=100;

height = 10; // [0:30]
eyelashAngle = 0; // [0:360]

leftWingAngle=60; // [0:90]
rightWingAngle=40; // [0:90]
wingsAngle=90;

lola(height, eyelashAngle);

module lola(height, eyelashAngle) {
    translate([0, 0, height]) {
        difference() {
            cupTop(height);
            wingProfileLeft();
            wingProfileLeftRight();
        }
        bigEye(eyelashAngle);
        smallEye();
        rotate([-leftWingAngle,0,0])
            wingLeft(height);
        rotate([-rightWingAngle,0,0])
            wingRight(height);
    }
    color("#303030") cylinder(r = 100, h = height * 2, center = true);

    translate([0, 0, - height]) {
        cupBottom(height);
    }

}

module wingLeft(height, wingWidth=2) {
    intersection() {
        difference() {
            cupTop(height);
            translate([0,0,1-wingWidth])
                cup(98);
        }
        wingProfileLeft();
    }
}

module wingRight(height, wingWidth=2) {
    intersection() {
        difference() {
            cupTop(height);
            translate([0,0,1-wingWidth])
                cup(98);
        }
        wingProfileLeftRight();
    }
    //axes();
}

module wingProfileLeft() {
    rotate([0,0,-wingsAngle])
        wingProfile();
}

module wingProfileLeftRight() {
    rotate([0,0,90+wingsAngle])
        wingProfile();
}

module wingProfile() {
    translate([0,0,-1])
    linear_extrude(100) {
        translate([20, 20]) {
            offset(10)
                intersection() {
                    circle(r = 65);
                    square(100);
                }
        }
    }
}


module bigEye(eyelashAngle) {
    rotate([13,0,0])
        translate([0,60,0])
            color("DarkBlue") sphere(d = 80);

    rotate([61,0,0])
        translate([0,63,-44])
            color("silver") eyeRing(34, eyelashAngle);
}

module eyeRing(diameter, eyelashAngle) {
    border_height=5;
    rounding=1;
    rotate([90,0,0]) {
        rotate_extrude(angle = 360)
            offset(r = rounding)
                translate([diameter, 0])
                    square([border_height, border_height]);
        rotate([0,0,45+eyelashAngle]) {
            //eyelash
            translate([0, 0, - 3])
                rotate_extrude(angle = 90)
                    offset(r = rounding)
                        translate([diameter, 0])
                            square([border_height, border_height]);
        }
    }
}

module smallEye() {
    rotate([13,0,-40]) 
        translate([0, 82, 0])
            color("DeepSkyBlue") sphere(d = 30);
}

module cupTop(height) {
    border_height=2.1;
    border_rounding=1;
    translate([0,0,border_height+border_rounding]) {
        color("FireBrick") cup();
        translate([0, 0, 20.01])
            color("white") cup(120);
    }
    color("FireBrick") cupBorder(border_height, border_rounding);
}

module cupBottom(height) {
    border_height=2.1;
    border_rounding=1;
    translate([0, 0, border_height - border_rounding]) {
        rotate([180, 0, 0])
            color("#202020") cup();
    }
    color("#202020") cupBorder(border_height, border_rounding);
}

module cupBorder(border_height, rounding) {
    rotate_extrude(angle=360)
        offset(r=rounding)
            translate([rounding, rounding])
                square([109.8, border_height-rounding], center = false);
}

module cup(cut=100) {
    size=300;
    difference() {
        translate([0, 0, - cut]) {
            sphere(d = size);
        }
        translate([0, 0, - size/2]) {
            cube(size, center = true);
        }
    }
}

module axes() {
    cube([1000,1,1]);
    cube([1,1000,1]);
    cube([1,1,1000]);
}