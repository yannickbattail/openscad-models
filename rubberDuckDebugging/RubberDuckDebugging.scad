/* [Text left] */
text_string1 = "Javascript";
text_size1 = 8;
text_position1 = [2, -2, 30];

/* [Text right] */
text_string2 = "HTML/CSS";
text_size2 = 8;
text_position2 = [-4, 0, 30];

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

$vpt = animation_rotation ? [0, 0, 0] : [];
$vpr = animation_rotation ? [70, 0, 365 * $t] : [];
$vpd = animation_rotation ? 500 : [];

font_params1 = [text_string1, text_size1, font_type, "center", "center", font_spacing, font_direction, font_language, font_script];
font_params2 = [text_string2, text_size2, font_type, "center", "center", font_spacing, font_direction, font_language, font_script];

duck(font_params1, text_position1, font_params2, text_position2);

module duck(font_params1, text_position1, font_params2, text_position2) {
  difference() {
    import("Rubber_Duck.stl", convexity = 10);
    rotate([0, 90, 00]) {
      translate(text_position1) {
        rotate([0, 0, 90]) {
          linear_extrude(height = 10, convexity = 10)
            text(text = font_params1[0], size = font_params1[1], font = font_params1[2], halign = font_params1[3], valign = font_params1[4], spacing = font_params1[5], direction = font_params1[6], language = font_params1[7], script = font_params1[8]);
        }
      }
    }
    rotate([0, -90, 0]) {
      translate(text_position2) {
        rotate([0, 0, -90]) {
          linear_extrude(height = 10, convexity = 10)
            text(text = font_params2[0], size = font_params2[1], font = font_params2[2], halign = font_params2[3], valign = font_params2[4], spacing = font_params2[5], direction = font_params2[6], language = font_params2[7], script = font_params2[8]);
        }
      }
    }
  }
}
