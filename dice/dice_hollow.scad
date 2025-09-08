// rounding of the dice
rounding = 0.69; // [0.6:0.01:0.8]
// hole size/depth
hole_size = 0.2; // [0.3:0.01:0.495]
// faces
faces = ["1", "2", "3", "4", "5", "6"];
// dice color
dice_color = "yellow"; // [yellow, red, green, blue, white, black]
// face (numbers) color
face_color = "red"; // [yellow, red, green, blue, white, black]

$fn = 50;
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
    color("orange")
    translate([0,0,0.1])
        cylinder(h=0.4001, r1=0, r2=0.45);

}

module faceText(letter) {
    face();
    color(face_color)
        translate([0, 0, hole_size]) {
            linear_extrude(1) text(text = letter, size = 0.6, halign = "center", valign = "center");
        }
}