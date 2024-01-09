include <BOSL/constants.scad>
use <BOSL/threading.scad>

part="all"; // [all, phoneHolder, hook, screw1, screw2, serratedWasher]

// saber blade diameter in inch
saberDiameterInch = 1; // [0.5:0.025:2]

// phone height, when in lanscape mode
phoneHeight = 74; // [50:1:200]
// phone width, when in lanscape mode
phoneWidth = 164; // [120:1:300]
// phone thickness
phoneThickness = 9; // [5:1:20]

/* [other parameter] */
// lenth of the hook (part around the saber)
hookLength = 20; // [20:5:50]
// Thickness of the phone Holder
phoneHolderThickness = 4; // [1:1:10]
// tolerance
tolerance = 0.5; // [0.1:0.1:1]

/* [display] */
// show the saber
displaySaber = false;
// show the phone
displayPhone = false;
// phone holder angle
phoneAngle = 30; // [0:90]

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated?[0, 0, 0]:[];
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:[]; // animation rotate around the object
$vpd = is_animated?1000:[];

phone = [phoneWidth, phoneThickness, phoneHeight];
// constant: 1 inch in mm
INCH = 25.4; // [25.4]
epsi = 0.01;

saberDiameter = saberDiameterInch * INCH;

if (part == "all") {
    hook(saberDiameter, tolerance);
    holder();
    screw1(saberDiameter);
    screw2();
} else if (part == "hook") {
    hook(saberDiameter, tolerance);
} else if (part == "phoneHolder") {
    holder();
} else if (part == "screw1") {
    screw1(saberDiameter);
} else if (part == "screw2") {
    screw2();
} else if (part == "serratedWasher") {
    serratedWashers();
}

if (displaySaber) {
    saber(saberDiameter);
}

module saber(saberDiameter) {
    translate([0, - 300, 0]) {
        rotate([- 90, 0, 0]) {
            color("chartreuse", 0.3)
                cylinder(d = saberDiameter, h = 800, center = true);
            color("black", 0.3)

                translate([0, 0, - 500])
                    cylinder(d = saberDiameter + 20, h = 200, center = true);
        }
        color("chartreuse", 0.3)
            translate([0, 400, 0])
                sphere(d = saberDiameter);
    }
}

module hook(saberDiameter, tolerance) {
    hookSize = saberDiameter + 10;
    difference() {
        union() {
            rotate([90, 0, 0])
                cylinder(d = hookSize, h = hookLength, center = true);
            //cube([hookSize + 20, hookLength, hookSize], center = true);
            translate([10, 0, 0])
                cube([hookSize + 20, hookLength, 10], center = true);
        }
        rotate([- 90, 0, 0])
            cylinder(d = saberDiameter + tolerance, h = 100, center = true);
        translate([10 + 2, 0, 0])
            cube([hookSize + 20 + epsi, hookLength + epsi, 2], center = true);
        translate([saberDiameter / 2 + 15, 0, 0])
            cylinder(d = 10 + 1, h = 100);
        translate([saberDiameter / 2 + 15, 0, -50])
            threaded_rod(d=10 + tolerance, l=100, pitch=2, internal=true);
    }
    fix(saberDiameter);
}

module screw1(saberDiameter) {
    translate([saberDiameter / 2 + 15, 0, 0]) {
        screw(10);
    }
}
module screw2() {
    translate([0, 0, saberDiameter / 2 + 5])
        translate([0, 0, 30])
            rotate([0, 90, 0])
                screw(20);
}

module screw(length) {
    threaded_rod(d=10, l=length, pitch=2);

    translate([0, 0, length / 2])
        cylinder(d = 12, h = 2, $fn = 6);
    translate([0, 0, length / 2 + 5])
        rotate([0,90,0])
            cylinder(d = 13, h = 3, center=true);
}

module fix(saberDiameter) {
    translate([0, 0, saberDiameter / 2 + 5]) {
        difference() {
            union() {
                translate([0, 0, 7.5 + tolerance])
                    cube([20, 20, 20+5 - tolerance*2], center = true);
                translate([- 10, - 10, 20])
                    cube([10, 20, 10]);
                translate([- 10, 0, 30])
                    rotate([0, 90, 0])
                        cylinder(h = 10, r = 10);
            }
            translate([0, 0, 30])
                rotate([0, 90, 0]) {
                    threaded_rod(d=10 + tolerance, l=20, pitch=2, internal=true);
                }
        }
    }
}

module holder() {
    translate([0, 0, saberDiameter / 2 + 5]) {
        translate([0, 0, 30])
            rotate([- phoneAngle, 0, 0])
                phoneHolder();
    }
}

module phoneHolder() {
    color("yellow")
    intersection() {
        difference() {
            union() {
                translate([0, -20, 0])
                    cube([20, 20, 20], center = true);
                translate([5, -10, 0])
                    cube([10, 20, 20], center = true);
                rotate([0, 90, 0])
                    cylinder(h = 10, r = 10);
            }
            rotate([0, 90, 0])
                cylinder(d = 10 + 1, h = 100, center = true);
        }
        rotate([90, 0, 0])
            cylinder(d = saberDiameter, h = 100, center=true);
    }
    phoneRack();
}

module phoneRack() {
    translate([0, - 30, 20]) {
        f = phoneHolderThickness;
        translate(-0.5 * [0, phone[1] + f + tolerance, 0]) {
            difference() {
                color("grey")
                    cube(phone + [f + tolerance, f + tolerance, 0], center = true);
                color("blue")
                    translate([0, 0, f])
                        cube(phone, center = true);
                translate([0, -f - 1, f])
                    cube(phone - [f, f, f], center = true);
            }
            if (displayPhone) {
                color("green", 0.5)
                    translate([0, 0, f])
                        cube(phone, center = true);
            }
        }
    }
}

module serratedWashers() {
    rotate([0,-90,0])
    difference() {
        serratedWasher();
        rotate([0,90,0])
            cylinder(d=10 + 1, h=2, $fn=36);
    }
}

module serratedWasher() {
    intersection() {
        step = 18;
        union() {
            for(i = [0:step]) {
                rotate([i * 360 / step, 0, 0])
                    translate([0, 0, -10]) {
                        linear_extrude(11, scale = [0, 0]) {
                            rotate([0, 0, 45])
                                square(3, center = true);
                        }
                    }
            }
        }
        rotate([0, 90, 0])
            cylinder(r = 10, h = 4, $fn = step * 2);
    }
}
