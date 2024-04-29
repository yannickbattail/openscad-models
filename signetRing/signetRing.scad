// part to generate
part="all"; // [all, signetRing, signetRingText]

// a base between the top of the ring and bottom of the text
base_height=1; // [0:0.1:10]
// border thickness around the text
border_size=1; // [-0.1:0.1:10]
// text height
text_height = 1; // [0.1:0.1:20]
// text on the top of the ring
ring_text = "Love";

/* [Font details] */
// The generated text has an ascent (height above the baseline) of approximately the given value.
font_size=5; // [0:0.1:20]
// The name of the font that should be used. This can also include a style parameter
font_type = "Arial";
// The name of the font that should be used. This can also include a style parameter
font_style = ""; // [Regular, Bold, Italic, Bold Italic]
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

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [Resolution] */
// resolution/quality
$fn=100;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated?[0, 0, 0]:[];
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:[]; // animation rotate around the object
$vpd = is_animated?120:[];

font_params=[font_size, (font_style != "")?str(font_type, ":style=", font_style):font_type, font_halign, font_valign, font_spacing, font_direction, font_language, font_script];

if (part == "signetRing") {
    rotate([0,180,0])
        signetRing();
} else if (part == "signetRingText") {
    signetRingText(base_height, border_size, text_height, ring_text, font_params);
} else {
    signetRing();
    signetRingText(base_height, border_size, text_height, ring_text, font_params);
}


module signetRingText(base_height, border_size, text_height, ring_text, font_params) {
    color("gold") {
        translate([0, 0, base_height])
            linear_extrude(text_height + 0.001)
                text(text = ring_text,
                size = font_params[0],
                font = font_params[1],
                halign = font_params[2],
                valign = font_params[3],
                spacing = font_params[4],
                direction = font_params[5],
                language = font_params[6],
                script = font_params[7]);
        scale([1, 0.8, 1]) {
            translate([0, 0, base_height])
                tube(d = 20, h = text_height, thickness = border_size);
            cylinder(d = 20, h = base_height);
        }
    }
}

module signetRing() {
    color("silver") {
        difference() {
            translate([0, 0, -9])
                scale([1, 0.8, 1.2])
                    sphere(d = 25);

            translate([0, 0, -12])
                rotate([90, 0, 0])
                    cylinder(d = 20, h = 50, center = true);

            translate([0, 0, 12])
                cube(24, center = true);

            translate([0, -44.3, -20])
                rotate([90, 0, 90])
                    cylinder(d = 80, h = 50, center = true);
            translate([0, 44.3, -20])
                rotate([90, 0, 90])
                    cylinder(d = 80, h = 50, center = true);
        }
    }
}

module tube(d, h, thickness) {
    epsi=0.01;
    difference() {
        cylinder(d = d, h = h);
        translate([0,0,-epsi])
            cylinder(d = d-thickness, h = h+2*epsi);
    }
}
