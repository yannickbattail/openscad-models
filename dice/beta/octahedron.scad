include <plato.scad>
// rounding of the dice
rounding = 0.5; // [0.4:0.01:0.6]
// hole size/depth
hole_size = 0.35; // [0.20:0.01:0.39]
// faces
faces = "🐀🐄🐊🐋🐌🐓🐒🐙";
// dice color
dice_color = "#ffffff";
// face (numbers) color
face_color = "#000000";

$fn = 100;

scale(10)
  dice(rounding, hole_size, faces, dice_color, face_color);
module dice(rounding, hole_size, faces, dice_color, face_color) {
  difference() {
    color(dice_color)
      intersection() {
        octahedron();
        sphere(rounding);
      }
    color(face_color) {
      color(face_color) {
        rotate([0, 50, 0])
          faceText(faces[0]); // 1
        rotate([0, 50, 90])
          faceText(faces[1]); // 2
        rotate([0, 50, 180])
          faceText(faces[2]); // 3
        rotate([0, 50, -90])
          faceText(faces[3]); // 4
        rotate([0, 130, 0])
          faceText(faces[5]); // 6
        rotate([0, 130, 90])
          faceText(faces[4]); // 5
        rotate([0, 130, 180])
          faceText(faces[7]); // 8
        rotate([0, 130, -90])
          faceText(faces[6]); // 7
      }
    }
  }
}
module faceText(letter) {
  translate([0, 0, hole_size]) {
    linear_extrude(1)
      rotate([0, 0, 90])
        text(text = letter, font = "Symbola:style=Regular", size = 0.5, halign = "center", valign = "center");
  }
}
