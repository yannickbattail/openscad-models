use <ducks.scad>

/* [Duck] */
// use a low polygon number version of the duck
lowpoly_duck = false;

/* [Text left] */
// text on left
text_string1 = "Javascript";
// text on left size
text_size1 = 7;
// text on left position [x,y,z]
text_position1 = [-1, 0, 0];

/* [Text right] */
// text on right
text_string2 = "HTML/CSS";
// text on right size
text_size2 = 8;
// text on right position [x,y,z]
text_position2 = [1, 0, 0];

/* [Font] */
// The name of the font that should be used. This can also include a style parameter
font_type = "Liberation Mono:style=Regular";
// Factor to increase/decrease the character spacing. The default value of 1 results in the normal spacing for the font, giving a value greater than 1 causes the letters to be spaced further apart.
font_spacing = 1; // [0:0.1:2]
// Direction of the text flow.
font_direction = "ltr"; // [ltr:left-to-right, rtl:right-to-left, ttb:top-to-bottom, btt:bottom-to-top]
// The language of the text
font_language = "en";
// The script of the text
font_script = "latin";

/* [Resolution] */
$fn = 100;

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [Hidden] */
$vpt = animation_rotation ? [0, 0, 0] : $vpt;
$vpr = animation_rotation ? [60, 0, animation_rotation ? (365 * $t) : 45] : $vpr; // animation rotate around the object
$vpd = animation_rotation ? 500 : $vpd;

font_params1 = [text_string1, text_size1, font_type, "center", "center", font_spacing, font_direction, font_language, font_script];
font_params2 = [text_string2, text_size2, font_type, "center", "center", font_spacing, font_direction, font_language, font_script];

duck(font_params1, text_position1, font_params2, text_position2, lowpoly_duck);

module duck(font_params1, text_position1, font_params2, text_position2, lowpoly_duck) {
  difference() {
    rubber_duck(lowpoly_duck);
    word(font_params1, text_position1, true);
    word(font_params2, text_position2, false);
  }
}

module word(font_params, text_position, isLeft) {
  position = text_position + (lowpoly_duck ? [34, 0, 20] : [30, 0, 20]);
  translate([position[0] * (isLeft ? 1 : -1), position[1], position[2]])
    rotate([90, 0, isLeft ? 90 : -90])
      linear_extrude(height = 20, convexity = 10)
        text(text = font_params[0], size = font_params[1], font = font_params[2], halign = font_params[3], valign = font_params[4], spacing =
        font_params[5], direction = font_params[6], language = font_params[7], script = font_params[8]);
}

module rubber_duck(lowpoly_duck) {
  if (lowpoly_duck) {
    translate([-280.175, 284.09, -22])
      scale(4)
        duck_low();
  } else {
    translate([0, 0, 22.74])
      duck_high();
  }
}
