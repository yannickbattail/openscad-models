// rounding of the dice
rounding = 0.69; // [0.6:0.01:0.8]
// hole size/depth
hole_size = 0.2; // [0.3:0.01:0.495]
// dice color
dice_color = "yellow"; // [yellow, red, green, blue, white, black]
// face (numbers) color
face_color = "red"; // [yellow, red, green, blue, white, black]

$fn = 100;

/* [Font] */
// The generated text has an ascent (height above the baseline) of approximately the given value.
font_size=0.6;  // [0:0.1:2]
// The name of the font that should be used. This can also include a style parameter
font_type = "Liberation Mono:style=Regular";
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

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated?[0, 0, 0]:$vpt;
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:$vpr; // animation rotate around the object
$vpd = is_animated?100:$vpd;

faces = [face_1, face_2, face_3, face_4, face_5, face_6];
font_params=[font_size, font_type, font_halign, font_valign, font_spacing, font_direction, font_language, font_script];

scale(10) dice(rounding, hole_size, faces, dice_color, face_color, font_params);
module dice(rounding, hole_size, faces, dice_color, face_color, font_params) {
    difference() {
        color(dice_color) intersection() {
            cube(1, center = true);
            sphere(rounding);
        }
        union(){
            rotate([0, 0, 0]) faceText(faces[0], font_params); // 1
            rotate([180, 0, 0]) faceText(faces[5], font_params); // 6
            rotate([90, 0, 0]) faceText(faces[1], font_params); // 2
            rotate([- 90, 0, 0]) faceText(faces[4], font_params); // 5
            rotate([90, 0, 90]) faceText(faces[2], font_params); // 3
            rotate([90, 0, - 90]) faceText(faces[3], font_params); // 4
        }
    }
}

module face() {
    color("orange")
    translate([0,0,0.1])
        cylinder(h=0.4001, r1=0, r2=0.45);

}

module faceText(letter, font_params) {
    face();
    color(face_color)
    translate([0, 0, hole_size]) {
        linear_extrude(1)
            text(text = letter,
                size = font_params[0],
                font = font_params[1],
                halign = font_params[2],
                valign = font_params[3],
                spacing = font_params[4],
                direction = font_params[5],
                language = font_params[6],
                script = font_params[7]);
        }
}