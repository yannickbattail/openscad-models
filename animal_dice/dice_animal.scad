// animal model
animalNumber = 0; // [0:Platypus_Barbarian, 1:VoxelHeart1_hull, 2:catLowPoly, 3:dino, 4:dragonLED, 5:duckVader, 6:foxLowPoly, 7:heart_gem, 8:panda, 9:vader]
// part
part = "whole"; // [whole, edge1_3]
// fixation bars diameter
fixation_diameter = 4;

/* [Font] */
// The generated text has an ascent (height above the baseline) of approximately the given value.
font_size = 10;  // [0:0.1:2]
// The name of the font that should be used. This can also include a style parameter
font_type = "Arial";
// The horizontal alignment for the text.
font_halign = "center"; // [left, center, right]
// The vertical alignment for the text.
font_valign = "center"; // [top, center, baseline, bottom]
// Factor to increase/decrease the character spacing. The default value of 1 results in the normal spacing for the font, giving a value greater than 1 causes the letters to be spaced further apart.
font_spacing = 1; // [0:0.1:2]
// Direction of the text flow.
font_direction = "ltr"; // [ltr:left-to-right, rtl:right-to-left, ttb:top-to-bottom, btt:bottom-to-top]
// The language of the text
font_language = "en";
// The script of the text
font_script = "latin";

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
font_params = [font_size, font_type, font_halign, font_valign, font_spacing, font_direction, font_language, font_script]
;

$vpt = animation_rotation ? [0, 0, 0] : [];
$vpr = animation_rotation ? [70, 0, 365 * $t] : [];
$vpd = animation_rotation ? 300 : [];

animals = import("animals_center_of_gravity.json");

dice_animal(animalNumber, fixation_diameter, faces, font_params);
//dicePart(model, fixation_diameter, faces, font_type, font_size);

function toInt(str) =
let(d = [for (s = str) ord(s) - 48], l = len(d) - 1)
    [for (i = 0, a = d[i];i <= l;i = i + 1, a = 10 * a + d[i]) a][l];

module dice_animal(animalNumber, fixation_diameter, faces, font_params) {
    dice(faces, font_params);
    fixation(fixation_diameter);
    animalInt = is_string(animalNumber) ? toInt(animalNumber) : animalNumber;
    animalConfig = animals[animalInt];
    echo("animalConfig ", animalNumber, animalInt, animalConfig);
    assert(!is_undef(animalConfig), "animalConfig is null");
    color("red")
        animalModel(animalConfig);
    // cube(77, center=true); // containing cube
}

module animalModel(animalConfig) {
    scale(animalConfig.scale)
        rotate(animalConfig.rotation)
            translate(-animalConfig.center_of_gravity)
                import(animalConfig.filename);
}

module dicePart(animalName, fixation_diameter, faces, font_type, font_size) {
    intersection() {
        dice(faces, font_type, font_size);
        rotate([45, 0, 0])
            translate([-50, 0, 0])
                cube(100);
        rotate([0, 0, -45])
            translate([0, 0, -50])
                cube(100);

    }
}

module dice(faces, font_params) {
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
}

module numberFaces(numberText, font_params) {
    rotate([0, 0, 0]) numbers(numberText[0], font_params); // 1
    rotate([180, 0, 0]) numbers(numberText[5], font_params); // 6
    rotate([90, 0, 0]) numbers(numberText[1], font_params); // 2
    rotate([-90, 0, 0]) numbers(numberText[4], font_params); // 5
    rotate([90, 0, 90]) numbers(numberText[2], font_params); // 3
    rotate([90, 0, -90]) numbers(numberText[3], font_params); // 4
}

module numbers(number, font_params) {
    for (i = [0:4]) {
        rotate([46, 0, 45 + 90 * i])
            translate([0, 0, 49.5])
                number(number, font_params);
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
    color("blue") {
        for (i = [0:4]) {
            rotate([55, 0, 45 + 90 * i])
                cylinder(h = 95, d = fixation_diameter, center = true);
        }
    }
}

