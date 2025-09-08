//The size of the die
size = 25;

//The number of sides of the die
die = 10;

//how round the corners should be as a factor of size
roundness = 0.15;

//How big the text should be, as a factor of the size
letter_ratio = 0.3;

//How deep the text should be, as a factor of the size
depth_ratio = 0.03;

//How far from the equator the kite tips drift towards the poles. Adjust manually based on the number of sides so that the polar triangles and equitorial triangles appear coplanar. (for die=10, kite=.052)
kite = 0.052;

//The additional angle from 45 that numbers must be rotated to be plane-parallel with the faces (for die=10, angular_fudge=3
angular_fudge = 3;

//The additional factor of size numbers must be translated to be coplanar with the faces (for die=10, radial_fudge=.125)
radial_fudge = 0.125;

//How many facets create the rounded corners. This will significantly affect the refresh time.
$fn = 20;

/* [faces] */
face_1 = "1";
face_2 = "2";
face_3 = "3";
face_4 = "4";
face_5 = "5";
face_6 = "6.";
face_7 = "7";
face_8 = "8";
face_9 = "9.";
face_10 = "10";

sides = [face_5, face_10, face_2, face_8, face_4, face_6, face_7, face_3, face_9, face_1];

dice10(die, size, kite, roundness, letter_ratio, depth_ratio, angular_fudge);

module trapezohedron(die, size, kite, roundness) {
  equitorial_n = floor(die / 2);
  hull() {
    for(i = [0:equitorial_n - 1]) {
      rotate([0, 0, i * 360 / equitorial_n])
        translate(size * [.5, 0, kite])
          sphere(d = roundness * size);
      rotate([0, 0, (i + .5) * 360 / equitorial_n])
        translate(size * [.5, 0, -kite])
          sphere(d = roundness * size);
    }
    translate(size * [0, 0, .5])
      sphere(d = roundness * size);
    translate(size * [0, 0, -.5])
      sphere(d = roundness * size);
  }
}

module dice10(die, size, kite, roundness, letter_ratio, depth_ratio, angular_fudge) {
  equitorial_n = floor(die / 2);

  difference() {
    trapezohedron(die, size, kite, roundness);

    //top numbers
    for(i = [0:die / 2 - 1]) {
      translate(.5 * size * [cos((i + .5) * 360 / equitorial_n), sin((i + .5) * 360 / equitorial_n), +.5])
        rotate([0, 45 + angular_fudge, (i + .5) * 360 / equitorial_n])
          face_text(i);
    }
    //bottom numbers
    for(i = [die / 2:die - 1]) {
      translate(.5 * size * [cos(i * 360 / equitorial_n), sin(i * 360 / equitorial_n), -.5])
        rotate([180, -45 - angular_fudge, i * 360 / equitorial_n])
          face_text(i);
    }
  }
}

module face_text(i) {
  rotate([0, 0, 90])
    translate([0, 0, (-radial_fudge - depth_ratio) * size + .05])
      linear_extrude(.25 * size)
        text(str(sides[i]), size = size * letter_ratio, valign = "center", halign = "center");
}
