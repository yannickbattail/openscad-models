// animal
part = "fox"; // [fox, dino, dragon, cat, panda, heart_gem]
// fixation bars diameter 
fixation_diameter = 4;

/* [Font] */
// The generated text has an ascent (height above the baseline) of approximately the given value.
font_size=10;  // [0:0.1:2]
// The name of the font that should be used. This can also include a style parameter
font_type = "Arial";
// The horizontal alignment for the text.
font_halign="center"; // [left, center, right]
// The vertical alignment for the text.
font_valign="center"; // [top, center, baseline, bottom]
// Factor to increase/decrease the character spacing. The default value of 1 results in the normal spacing for the font, giving a value greater than 1 causes the letters to be spaced further apart.
font_spacing=1; // [0:0.1:2]
// Direction of the text flow.
font_direction="ltr"; // [ltr:left-to-right, rtl:right-to-left, ttb:top-to-bottom, btt:bottom-to-top]
// The language of the text
font_language="en";
// The script of the text
font_script="latin";

/* [Faces] */
// text on face 1 (top)
face_1 = "1";
// text on face 2 (front)
face_2 = "2";
// text on face 3 (right)
face_3 = "3";
// text on face 4 (left)
face_4 = "4";
// text on face 5 (back)
face_5 = "5";
// text on face 6 (bottom)
face_6 = "6";

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [hidden] */
$fn = 100;

faces = [face_1, face_2, face_3, face_4, face_5, face_6];
font_params=[font_size, font_type, font_halign, font_valign, font_spacing, font_direction, font_language, font_script];

$vpt = animation_rotation ? [0, 0, 0] : [];
$vpr = animation_rotation ? [70, 0, 365 * $t] : [];
$vpd = animation_rotation ? 300 : [];

dice(part, fixation_diameter, faces, font_params);

module dice(animalName, fixation_diameter, faces, font_params) {
    difference() {
        color("yellow")
            sphere(d = 100);
        r = 32;
        cylinder(r = r, h = 200, center = true);
        rotate([0, 90, 0])
            cylinder(r = r, h = 200, center = true);
        rotate([90, 0, 0])
            cylinder(r = r, h = 200, center = true);
        numberFaces(faces, font_params);
    }
    fixation(fixation_diameter);
    color("orange") animal(animalName);
    // cube(77, center=true); // containing cube
}

module numberFaces(numberText, font_params) {
    every_faces=[
            [0,   0, 0  ], // 1 top
            [90,  0, 0  ], // 2 front
            [90,  0, 90 ], // 3 right
            [90,  0, -90], // 4 left
            [-90, 0, 0  ], // 5 back
            [180, 0, 0  ]  // 6 bottom
        ];
    color(face_color)
    for (i = [0:len(every_faces)-1]) {
        rotate(every_faces[i]) numbers(faces[i], font_params);
    }
}

module numbers(number, font_params) {
    for (i = [0:4]) {
        rotate([46, 0, 45 + 90 * i])
            translate([0, 0, 49])
                number(number, font_type, font_size);
    }
}

module number(number, font_params) {
    linear_extrude(10)
        text(text = number,
            size = font_params[0],
            font = font_params[1],
            halign = font_params[2],
            valign = font_params[3],
            spacing = font_params[4],
            direction = font_params[5],
            language = font_params[6],
            script = font_params[7]);
}

module fixation(fixation_diameter) {
    color("red") {
        for (i = [0:4]) {
            rotate([55, 0, 45 + 90 * i]) cylinder(h = 100, d = fixation_diameter, center = true);
        }
    }
}

module animal(animalName) {
    if (animalName == "panda") {
        animalModel(file = "animals/panda.stl", scalePercent = 0.9, centerOfGravity = [- 4.45929179e-05, 6.49922599e+00, 2.36770148e+01]);
    } else if (animalName == "dino") {
        animalModel(file = "animals/dino.stl", scalePercent = 0.9, centerOfGravity = [44.24588094, 68.37104575, 24.26177268]);
    } else if (animalName == "dragon") {
        animalModel(file = "animals/dragonLED.stl", scalePercent = 1.1, centerOfGravity = [- 1.74671741, - 0.06900702, 5.67328133]);
    } else if (animalName == "cat") {
        animalModel(file = "animals/catLowPoly.stl", scalePercent = 0.6, centerOfGravity = [- 0.60620592, 0.16325684, 39.43318665]);
    } else if (animalName == "fox") {
        animalModel(file = "animals/foxLowPoly.stl", scalePercent = 0.25, centerOfGravity = [- 14.18385003, 4.57492739, 75.20926315]);
    } else if (animalName == "heart_gem") {
        animalModel(file = "animals/heart_gem.stl", scalePercent = 0.7, centerOfGravity = [3.84325029e-03, 1.01203855e+00, 1.12715415e+01], rotation = [180, 0, 0]);
    } else {
        assert(true, str("wrong animalname", animalName));
    }
}

module animalModel(file, scalePercent, centerOfGravity, rotation = [0, 0, 0]) {
    scale([scalePercent, scalePercent, scalePercent])
        rotate(rotation)
            translate(- centerOfGravity)
                import(file);
}
