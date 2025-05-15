// animal
part = "heart"; // [heart, Damagetypes-Acit, Damagetypes-Bludgeoning, Damagetypes-Cold, Damagetypes-Fire, Damagetypes-Force, Damagetypes-Lightning, Damagetypes-Necrotic, Damagetypes-Piercing, Damagetypes-Poison, Damagetypes-Psychic, Damagetypes-Radiant, Damagetypes-Slashing, Damagetypes-Thunder]
// fixation bars diameter
fixation_diameter = 4;
// The diameter of the edge
radius = 0.1; // [0.01:0.01:0.2]
// The radius of the fixation bars
radiusFix = 0.04; // [0.01:0.01:0.2]

/* [Font] */
// The generated text has an ascent (height above the baseline) of approximately the given value.
font_size = 0.6;  // [0:0.1:2]
// The name of the font that should be used. This can also include a style parameter
font_type = "Liberation Mono:style=Regular";
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
font_params = [font_size, font_type, font_halign, font_valign, font_spacing, font_direction, font_language, font_script];

$vpt = animation_rotation ? [0, 0, 0] : [];
$vpr = animation_rotation ? [70, 0, 365 * $t] : [];
$vpd = animation_rotation ? 300 : [];

include <icosahedron.scad>

dice_animal(part, fixation_diameter, faces, font_params);

module dice_animal(animalName, fixation_diameter, faces, font_params) {
    dice();
    color("red")
        animal(animalName);
}

module dice() {
    scale(50)
        icosahedron();
}

module animal(animalName) {
    if (animalName == "heart") {
        animalModel(file = "animals/VoxelHeart1_hull.stl", scalePercent = 25, centerOfGravity = [-1.33321397e-10, -
        2.47270318e-10, 2.82393425e-01], rotation = [0, 0, 0]);
    } else if (animalName == "Damagetypes-Acit") {
        animalModel(file = "animals/Damagetypes-Acit.stl", scalePercent = 25, centerOfGravity = [-1.33321397e-10, -
        2.47270318e-10, 2.82393425e-01], rotation = [0, 0, 0]);
    } else if (animalName == "Damagetypes-Bludgeoning") {
        animalModel(file = "animals/Damagetypes-Bludgeoning.stl", scalePercent = 25, centerOfGravity = [-1.33321397e-10, -
        2.47270318e-10, 2.82393425e-01], rotation = [0, 0, 0]);
    } else if (animalName == "Damagetypes-Cold") {
        animalModel(file = "animals/Damagetypes-Cold.stl", scalePercent = 25, centerOfGravity = [-1.33321397e-10, -
        2.47270318e-10, 2.82393425e-01], rotation = [0, 0, 0]);
    } else if (animalName == "Damagetypes-Fire") {
        animalModel(file = "animals/Damagetypes-Fire.stl", scalePercent = 25, centerOfGravity = [-1.33321397e-10, -
        2.47270318e-10, 2.82393425e-01], rotation = [0, 0, 0]);
    } else if (animalName == "Damagetypes-Force") {
        animalModel(file = "animals/Damagetypes-Force.stl", scalePercent = 25, centerOfGravity = [-1.33321397e-10, -
        2.47270318e-10, 2.82393425e-01], rotation = [0, 0, 0]);
    } else if (animalName == "Damagetypes-Lightning") {
        animalModel(file = "animals/Damagetypes-Lightning.stl", scalePercent = 25, centerOfGravity = [-1.33321397e-10, -
        2.47270318e-10, 2.82393425e-01], rotation = [0, 0, 0]);
    } else if (animalName == "Damagetypes-Necrotic") {
        animalModel(file = "animals/Damagetypes-Necrotic.stl", scalePercent = 25, centerOfGravity = [-1.33321397e-10, -
        2.47270318e-10, 2.82393425e-01], rotation = [0, 0, 0]);
    } else if (animalName == "Damagetypes-Piercing") {
        animalModel(file = "animals/Damagetypes-Piercing.stl", scalePercent = 25, centerOfGravity = [-1.33321397e-10, -
        2.47270318e-10, 2.82393425e-01], rotation = [0, 0, 0]);
    } else if (animalName == "Damagetypes-Poison") {
        animalModel(file = "animals/Damagetypes-Poison.stl", scalePercent = 25, centerOfGravity = [-1.33321397e-10, -
        2.47270318e-10, 2.82393425e-01], rotation = [0, 0, 0]);
    } else if (animalName == "Damagetypes-Psychic") {
        animalModel(file = "animals/Damagetypes-Psychic.stl", scalePercent = 25, centerOfGravity = [-1.33321397e-10, -
        2.47270318e-10, 2.82393425e-01], rotation = [0, 0, 0]);
    } else if (animalName == "Damagetypes-Radiant") {
        animalModel(file = "animals/Damagetypes-Radiant.stl", scalePercent = 25, centerOfGravity = [-1.33321397e-10, -
        2.47270318e-10, 2.82393425e-01], rotation = [0, 0, 0]);
    } else if (animalName == "Damagetypes-Slashing") {
        animalModel(file = "animals/Damagetypes-Slashing.stl", scalePercent = 25, centerOfGravity = [-1.33321397e-10, -
        2.47270318e-10, 2.82393425e-01], rotation = [0, 0, 0]);
    } else if (animalName == "Damagetypes-Thunder") {
        animalModel(file = "animals/Damagetypes-Thunder.stl", scalePercent = 25, centerOfGravity = [-1.33321397e-10, -
        2.47270318e-10, 2.82393425e-01], rotation = [0, 0, 0]);
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
