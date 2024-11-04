// animal
part = "fox"; // [fox, dino, dragon, cat, panda, heart_gem, VoxelHeart]
// fixation bars diameter 
fixation_diameter = 4;
// font type
font_type = "Arial";
// font_size
font_size = 10;

/* [Faces] */
// text on face 1
face_1 = "1";
// text on face 2
face_2 = "2";
// text on face 3
face_3 = "3";
// text on face 4
face_4 = "4";
// text on face 5
face_5 = "5";
// text on face 6
face_6 = "6";

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [hidden] */
$fn = 100;

faces = [face_1, face_2, face_3, face_4, face_5, face_6];

$vpt = animation_rotation ? [0, 0, 0] : [];
$vpr = animation_rotation ? [70, 0, 365 * $t] : [];
$vpd = animation_rotation ? 300 : [];

dice(part, fixation_diameter, faces, font_type, font_size);

module dice(animalName, fixation_diameter, faces, font_type, font_size) {
    difference() {
        color("yellow")
            sphere(d = 100);
        r = 32;
        cylinder(r = r, h = 200, center = true);
        rotate([0, 90, 0])
            cylinder(r = r, h = 200, center = true);
        rotate([90, 0, 0])
            cylinder(r = r, h = 200, center = true);
        numberFaces(faces, font_type, font_size);
    }
    fixation(fixation_diameter);
    color("red") animal(animalName);
    // cube(77, center=true); // containing cube
}

module numberFaces(numberText, font_type, font_size) {
    rotate([0, 0, 0]) numbers(numberText[0], font_type, font_size); // 1
    rotate([180, 0, 0]) numbers(numberText[5], font_type, font_size); // 6
    rotate([90, 0, 0]) numbers(numberText[1], font_type, font_size); // 2
    rotate([-90, 0, 0]) numbers(numberText[4], font_type, font_size); // 5
    rotate([90, 0, 90]) numbers(numberText[2], font_type, font_size); // 3
    rotate([90, 0, -90]) numbers(numberText[3], font_type, font_size); // 4
}

module numbers(number, font_type, font_size) {
    for (i = [0:4]) {
        rotate([46, 0, 45 + 90 * i])
            translate([0, 0, 49])
                number(number, font_type, font_size);
    }
}

module number(number, font_type, font_size) {
    linear_extrude(10)
        text(text = number, font = font_type, size = font_size, halign = "center", valign = "center");
}

module fixation(fixation_diameter) {
    color("blue") {
        for (i = [0:4]) {
            rotate([55, 0, 45 + 90 * i]) cylinder(h = 100, d = fixation_diameter, center = true);
        }
    }
}

module animal(animalName) {
    if (animalName == "panda") {
        animalModel(file = "animals/panda.stl", scalePercent = 0.9, centerOfGravity = [-4.45929179e-05, 6.49922599e+00,
            2.36770148e+01]);
    } else if (animalName == "dino") {
        animalModel(file = "animals/dino.stl", scalePercent = 0.9, centerOfGravity = [44.24588094, 68.37104575,
            24.26177268]);
    } else if (animalName == "dragon") {
        animalModel(file = "animals/dragonLED.stl", scalePercent = 1.1, centerOfGravity = [-1.74671741, -0.06900702,
            5.67328133]);
    } else if (animalName == "cat") {
        animalModel(file = "animals/catLowPoly.stl", scalePercent = 0.6, centerOfGravity = [-0.60620592, 0.16325684,
            39.43318665]);
    } else if (animalName == "fox") {
        animalModel(file = "animals/foxLowPoly.stl", scalePercent = 0.25, centerOfGravity = [-14.18385003, 4.57492739,
            75.20926315]);
    } else if (animalName == "heart_gem") {
        animalModel(file = "animals/heart_gem.stl", scalePercent = 0.7, centerOfGravity = [3.84325029e-03,
            1.01203855e+00, 1.12715415e+01], rotation = [180, 0, 0]);
    } else if (animalName == "VoxelHeart") {
        animalModel(file = "animals/VoxelHeart1_hull.stl", scalePercent = 25, centerOfGravity = [-1.78855650e-09,
            1.70348953e-10, 2.82393421e-01]);
    } else {
        assert(true, str("wrong animalname", animalName));
    }
}

module animalModel(file, scalePercent, centerOfGravity, rotation = [0, 0, 0]) {
    scale([scalePercent, scalePercent, scalePercent])
        rotate(rotation)
            translate(-centerOfGravity)
                import(file);
}
