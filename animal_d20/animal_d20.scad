// animal
part = 13; // [0:Damagetypes-Acid, 1:Damagetypes-Bludgeoning, 2:Damagetypes-Cold, 3:Damagetypes-Fire, 4:Damagetypes-Force, 5:Damagetypes-Lightning, 6:Damagetypes-Necrotic, 7:Damagetypes-Piercing, 8:Damagetypes-Poison, 9:Damagetypes-Psychic, 10:Damagetypes-Radiant, 11:Damagetypes-Slashing, 12:Damagetypes-Thunder, 13:VoxelHeart1_hull]
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

animals = import("animals_center_of_gravity.json");

dice_animal(part, fixation_diameter, faces, font_params);

module dice_animal(animalNumber = 0, fixation_diameter, faces, font_params) {
    dice();
    animalConfig = animals[animalNumber];
    echo("animalConfig ", animalNumber, animalConfig);
    color("red")
        animalModel(animalConfig);
}

module dice() {
    scale(50)
        icosahedron();
}

module animalModel(animalConfig) {
    scale([animalConfig.scale, animalConfig.scale, animalConfig.scale])
        rotate(animalConfig.rotation)
            translate(-animalConfig.center_of_gravity)
                import(animalConfig.filename);
}
