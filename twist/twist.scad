/**
* licence CC0
* Author: Yannick Battail
*/

NbArms = 5; // [2:1:20]
Height = 200; // [1:1:200]
DistFromBorder = 30; // [1:1:200]
ArmRadius = 10; // [2:1:20]
TopCone_percentHeight = 85; // [0:5:100]
InsideCone = false;
Bottom = true;
TopHook = true;

/* [Animation] */
animArms = false;
animHeight = false;
animDistFromBorder = false;
animArmRadius = false;
animTopCone_percentHeight = false;

/* [Hidden] */
$vpt = [0, 0, 0];
$vpr = [60, 0, 45];
$vpd = 1000;
$fn = 100;
epsi = 0.01;

animate();

module animate() {
    nbArms = animArms ? $t * 10 + 2 : NbArms;
    height = animHeight ? $t * 150 + 20 : Height;
    distFromBorder = animDistFromBorder ? $t * 200 + 30 : DistFromBorder;
    armRadius = animArmRadius ? $t * 18 + 2 : ArmRadius;
    topCone_percentHeight = animTopCone_percentHeight ? $t * 50 + 45 : TopCone_percentHeight;
    insideCone = InsideCone;
    bottom = Bottom;
    topHook = TopHook;

    coneTentacle(nbArms, height, distFromBorder, armRadius, topCone_percentHeight, insideCone, bottom, topHook);
}

module coneTentacle(nbArms, height, distFromBorder, armRadius, topCone_percentHeight, insideCone, bottom, topHook) {
    tentacle(nbArms, height, distFromBorder, armRadius, topCone_percentHeight, insideCone, bottom, topHook);
    if (bottom) {
        mirror([0, 1, 0])
            mirror([0, 0, 1]) {
                tentacle(nbArms, height, distFromBorder, armRadius, topCone_percentHeight, insideCone, bottom, topHook);
            }
    }
    if (topHook)
    top(nbArms, height, distFromBorder, armRadius, topCone_percentHeight, insideCone, bottom, topHook);
}

module tentacle(nbArms, height, distFromBorder, armRadius, topCone_percentHeight, insideCone, bottom, topHook) {
    for (i = [0:nbArms]) {
        rotate([0, 0, i * 360 / nbArms])
            {
                linear_extrude(height, twist = 360, scale = [0, 0]) {
                    translate([distFromBorder, 0]) circle(r = armRadius);
                }
            }
    }
    if (insideCone) {
        cylinder(h = height, r1 = distFromBorder, r2 = 0);
    }
    difference() {
        width = distFromBorder + armRadius;
        cylinder(h = height, r1 = width, r2 = 0);
        translate([- width, - width, - epsi])
            cube([width * 2, width * 2, height * topCone_percentHeight / 100]);
    }
}

module top(nbArms, height, distFromBorder, armRadius, topCone_percentHeight, insideCone, bottom, topHook) {
    translate([0, 0, height - 1]) {
        translate([- 7, 0, 0])
            rotate([0, 45, 0])
                cylinder(h = 10, d = 2);
        translate([7, 0, 0])
            rotate([0, - 45, 00])
                cylinder(h = 10, d = 2);
        translate([0, 0, 7])
            sphere(d = 2);
    }
    invertPercent = 1 - topCone_percentHeight / 100;
    difference() {
        width = distFromBorder + armRadius;
        cylinder(h = height, r = (distFromBorder + armRadius) * invertPercent);
        translate([- width, - width, - epsi])
            cube([width * 2, width * 2, height * topCone_percentHeight / 100]);
    }
}
