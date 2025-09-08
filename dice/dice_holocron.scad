// dice color
dice_color = "blue"; // [orange, yellow, red, green, blue, white, black]
// face (numbers) color
face_color = "orange"; // [orange yellow, red, green, blue, white, black]

/* [Font] */
// The generated text has an ascent (height above the baseline) of approximately the given value.
font_size = 40; // [5:1:50]
// The name of the font that should be used. This can also include a style parameter
font_type = "Bauhaus 93";
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

$fn = 100;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated ? [0, 0, 0] : $vpt;
$vpr = is_animated ? [60, 0, animation_rotation ? (365 * $t) : 45] : $vpr; // animation rotate around the object
$vpd = is_animated ? 500 : $vpd;

faces = [face_1, face_2, face_3, face_4, face_5, face_6];
font_params = [font_size, font_type, font_halign, font_valign, font_spacing, font_direction, font_language, font_script];

dice(faces, dice_color, face_color, font_params);

module dice(faces, dice_color, face_color, font_params) {
  every_faces = [
    [0, 0, 0], // 1 top
    [90, 0, 0], // 2 front
    [90, 0, 90], // 3 right
    [90, 0, -90], // 4 left
    [-90, 0, 0], // 5 back
    [180, 0, 0] // 6 bottom
  ];
  cube([100, 100, 100], center = true);
  for(i = [0:len(every_faces) - 1]) {
    rotate(every_faces[i])
      holocronFace(faces[i], font_params, face_color, dice_color);
  }
}

module holocronFace2D(letter, font_params) {
  difference() {
    square([100, 100], center = true);
    square([92, 92], center = true);
  }
  difference() {
    circle(d = 100);
    circle(d = 96);
  }
  rotate([0, 0, 45]) {
    difference() {
      square([70, 70], center = true);
      square([62, 62], center = true);
    }
    difference() {
      square([50, 50], center = true);
      square([46, 46], center = true);
    }
  }
  difference() {
    circle(d = 50);
    circle(d = 47);
  }
}

module faceText(letter, font_params) {
  text(text = letter, size = font_params[0], font = font_params[1], halign = font_params[2], valign = font_params[3], spacing = font_params[4], direction = font_params[5], language = font_params[6], script = font_params[7]);
}

module holocronFace(letter, font_params, face_color, dice_color) {
  translate([0, 0, 50]) {
    color(dice_color)
      cube([100, 100, 1], center = true);
    color(face_color)
      linear_extrude(2) {
        holocronFace2D();
        faceText(letter, font_params);
      }
  }
}
