// rounding of the dice
rounding = 0.69; // [0.6:0.01:0.8]
// hole size/depth
hole_size = 0.49; // [0.3:0.01:0.495]
// faces
faces = ["1", "2", "3", "4", "5", "6"];
// dice color
dice_color = "yellow"; // [yellow, red, green, blue, white, black]
// face (numbers) color
face_color = "red"; // [yellow, red, green, blue, white, black]
// animal
animalName = "fox"; // [fox, BunnyBabyNew, BunnySplitEar ]
// 
numberText = "123456"; 
use <foxLowPoly.scad>;

$fn = 100;
scale(50) dice(animalName, rounding, hole_size, faces, dice_color, face_color, numberText);

module dice(animalName, rounding, hole_size, faces, dice_color, face_color, numberText) {
    difference() {
        color(dice_color)
            sphere(d = 1);
        r = 0.32;
        cylinder(r = r, h = 2, center = true);
        rotate([0, 90, 0])
            cylinder(r = r, h = 2, center = true);
        rotate([90, 0, 0])
            cylinder(r = r, h = 2, center = true);
        numberFaces(numberText);
    }
    fixation();
    animal(animalName);
}

module numberFaces(numberText) {
    rotate([0, 0, 0]) numbers(numberText[0]); // 1
    rotate([180, 0, 0]) numbers(numberText[5]); // 6
    rotate([90, 0, 0]) numbers(numberText[1]); // 2
    rotate([- 90, 0, 0]) numbers(numberText[4]); // 5
    rotate([90, 0, 90]) numbers(numberText[2]); // 3
    rotate([90, 0, - 90]) numbers(numberText[3]); // 4
}

module numbers(number) {
    for (i = [0:4]) {
        rotate([46, 0, 45 + 90 * i])
            translate([0, 0, 0.49])
                number(number);
    }
}

module number(number) {
    linear_extrude(0.1)
        text(text = number, font = "Arial", size = 0.1, halign = "center", valign = "center");
}

module fixation() {
    color("red") {
        for (i = [0:4]) {
            rotate([55, 0, 45 + 90 * i]) cylinder(h = 1, r = 0.02, center = true);
        }
    }
}

module animal(animalName) {
    color("white") {
        if (animalName == "fox") {
            fox();
        } else if (animalName == "BunnyBabyNew") {
            BunnyBabyNew();
        } else if (animalName == "BunnySplitEar") {
            BunnySplitEar();
        } else {
            assert(true, str("wrong animalname", animalName));
        }
    }
}

module fox() {
    echo("fox");
    scalePercent = 0.0025;
    scale([scalePercent, scalePercent, scalePercent])
        rotate([0, 0, 0])
            // translate to center of gravity
            translate(-[-14.18385003, 4.57492739, 75.20926315])
                foxLowPoly();
}

module BunnyBabyNew() {
    echo("BunnyBabyNew");
    scalePercent = 0.215;
    scale([scalePercent, scalePercent, scalePercent])
        rotate([-20, 0, 0])
            // translate to center of gravity
            translate(-[0.00265889, - 0.00501949, - 0.8709599])
                import("BunnyBabyNew.stl");
}

module BunnySplitEar() {
    echo("BunnySplitEar");
    scalePercent = 0.2;
    scale([scalePercent, scalePercent, scalePercent])
        rotate([0, 0, 0])
            // translate to center of gravity
            translate(-[0.00153333, - 0.00239787, - 0.90748923])
                import("BunnySplitEar.stl");
}

