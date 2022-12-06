// rounding of the dice
rounding = 0.69; // [0.6:0.01:0.8]
// hole size/depth
hole_size = 0.1; // [0.3:0.01:0.495]
// dice color
dice_color = "yellow"; // [yellow, red, green, blue, white, black]
// face (numbers) color
face_color = "red"; // [yellow, red, green, blue, white, black]

$fn = 100;

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
$vpd = is_animated?200:$vpd;

faces = [face_1, face_2, face_3, face_4, face_5, face_6];

scale(10) dice(rounding, hole_size, faces, dice_color, face_color);
module dice(rounding, hole_size, faces, dice_color, face_color) {
    difference() {
        color(dice_color) intersection() {
            cube(1, center = true);
            sphere(rounding);
        }
         union(){
            rotate([0, 0, 0]) faceText(faces[0]); // 1
            rotate([180, 0, 0]) faceText(faces[5]); // 6
            rotate([90, 0, 0]) faceText(faces[1]); // 2
            rotate([- 90, 0, 0]) faceText(faces[4]); // 5
            rotate([90, 0, 90]) faceText(faces[2]); // 3
            rotate([90, 0, - 90]) faceText(faces[3]); // 4
        }
    }
}

module face() {
    translate([0, 0, 0.60]) {
        color("orange")
       sphere(0.48);
    }
}

module faceText(letter) {
    face();
    color(face_color)
    translate([0, 0, hole_size]) {
        linear_extrude(1) text(text = letter, size = 0.2, halign = "center", valign = "center");
    }
}