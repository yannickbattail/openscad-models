

part="all"; // [all, phoneHolder, hook]

// saber blade diameter in inch
saberDiameterInch = 1; // [0.5:0.025:2]

// lenth of the hook (part around the saber)
hookLength = 40; // [10:50]
// tolerance
tolerance = 0.5; // [0.1:0.1:1]

/* [phone] */
// phone height, when in lanscape mode
phoneHeight = 80; // [50:1:200]
// phone width, when in lanscape mode
phoneWidth = 180; // [120:1:300]
// phone thickness
phoneThickness = 10; // [5:1:20]

/* [display] */
// show the saber
displaySaber = true;
// phone holder andgle
phoneAngle = 30; // [0:90]

/* [Hidden] */
$fn = 50;

phone = [phoneWidth, phoneThickness, phoneHeight];
// constant: 1 inch in mm
INCH = 25.4; // [25.4]
epsi = 0.01;

saberDiameter = saberDiameterInch * INCH;

if (part == "hook" || part == "all") {
    hook(saberDiameter, tolerance);
}

if (part == "phoneHolder" || part == "all") {
    holder();
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
        translate([10, 0, 0])
            cube([hookSize + 20, hookLength, hookSize], center = true);
        rotate([- 90, 0, 0])
            cylinder(d = saberDiameter + tolerance, h = 100, center = true);
        translate([10 + 2, 0, 0])
            cube([hookSize + 20 + epsi, hookLength + epsi, 2], center = true);
        translate([saberDiameter / 2 + 10, 0, 0])
            cylinder(d = 5 + tolerance, h = 100, center = true);
    }
    screw1(saberDiameter);
    fix(saberDiameter);
}

module screw1(saberDiameter) {
    hookSize = saberDiameter + 10;
    translate([saberDiameter / 2 + 10, 0, 0]) {
        screw(hookSize + 10);
    }
}

module screw(length) {
    if (part == "all") {
        cylinder(d = 5, h = length, center = true);
    
        translate([0, 0, length / 2])
            cylinder(d = 10, h = 5, $fn = 6);
    
        translate([0, 0, - length])
            difference() {
                cylinder(d = 10, h = 5, $fn = 6);
                cylinder(d = 5, h = 100, center = true);
            }
    }
}

module fix(saberDiameter) {
    translate([0, 0, saberDiameter / 2 + 5]) {
        difference() {
            union() {
                translate([0, 0, 10])
                    cube([20, 20, 20], center = true);
                translate([- 10, - 10, 20])
                    cube([10, 20, 10]);
                translate([- 10, 0, 30])
                    rotate([0, 90, 0])
                        cylinder(h = 10, r = 10);
            }
            translate([0, 0, 30])
                rotate([0, 90, 0])
                    cylinder(d = 5 + tolerance, h = 100, center = true);
        }
        translate([0, 0, 30])
            rotate([0, 90, 0])
                screw(30);
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
    difference() {
        union() {
            translate([0, - 20, 0])
                cube([20, 20, 20], center = true);
            translate([5, - 10, 0])
                cube([10, 20, 20], center = true);
            rotate([0, 90, 0])
                cylinder(h = 10, r = 10);
        }
        rotate([0, 90, 0])
            cylinder(d = 5 + tolerance, h = 100, center = true);
    }
    translate([0, - 30, 20]) {
        f = 5;
        translate(- 0.5 * [0, phone[1] + f + tolerance, 0])
            difference() {
                color("grey")
                    cube(phone + [f + tolerance, f + tolerance, 0], center = true);
                color("blue")
                    translate([0, 0, f])
                        cube(phone, center = true);
                translate([0, - f - 1, f])
                    cube(phone - [f, f, f], center = true);
            }
    }
}
