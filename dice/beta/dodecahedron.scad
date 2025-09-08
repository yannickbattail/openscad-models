//The size of the die
size = 25;

//How big the text should be, as a factor of the size
letter_ratio = 0.45;

//How deep the text should be, as a factor of the size
depth_ratio = 0.03;

//how rounds faces are round
face_rounding = 0.80; //[0.72:0.01:0.87]

// resolution
$fn = 100;

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
face_11 = "11";
face_12 = "12";


//The text that should appear on each side of the die (accepts numbers, text or unicode)
sides = [face_12, face_2, face_10, face_4, face_9, face_6, face_8, face_7, face_5, face_3, face_11, face_1];
dice12(size, letter_ratio, depth_ratio, face_rounding, sides);

//calculates the vector of the center of the face x, based on the average of the vertices
function avg(x, points, faces) =
  (points[faces[x][0]] + points[faces[x][1]] + points[faces[x][2]] + points[faces[x][3]] + points[faces[x][4]]) / 5;

module dice12(size, letter_ratio, depth_ratio, face_rounding, sides) {
  dodecahedron_poly = dodecahedron();
  points = dodecahedron_poly[0];
  faces = dodecahedron_poly[1];
  difference() {
    intersection() {
      polyhedron(0.5 * size * points, faces);
      sphere(size * face_rounding);
    }
    for(i = [0:11]) {
      faceText(i, sides[i], size, letter_ratio, depth_ratio, points, faces);
    }
  }
}

module faceText(i, side, size, letter_ratio, depth_ratio, points, faces) {
  translate(.5 * size * avg(i, points, faces)) {
    rotate([0, acos(avg(i, points, faces)[2] / norm(avg(i, points, faces))), atan2(avg(i, points, faces)[1], avg(i, points, faces)[0])]) {
      translate([0, 0, -depth_ratio * size + .05]) {
        linear_extrude(depth_ratio * size) {
          text(str(side), size = size * letter_ratio, valign = "center", halign = "center");
        }
      }
    }
  }
}

function dodecahedron() =
  let (
  // golden_ratio
  g = (1 + sqrt(5)) / 2 + 0, 
  //See: https://en.wikipedia.org/wiki/Regular_dodecahedron#Cartesian_coordinates
  rect1 = [
    [+1, +1, +1],
    [+1, -1, +1],
    [-1, +1, +1],
    [-1, -1, +1]
  ], rect2 = [
    [+1, +1, -1],
    [+1, -1, -1],
    [-1, +1, -1],
    [-1, -1, -1]
  ], rect3 = [
    [0, +g, +1 / g],
    [0, +g, -1 / g],
    [0, -g, +1 / g],
    [0, -g, -1 / g]
  ], rect4 = [
    [+1 / g, 0, +g],
    [-1 / g, 0, +g],
    [+1 / g, 0, -g],
    [-1 / g, 0, -g]
  ], rect5 = [
    [+g, +1 / g, 0],
    [+g, -1 / g, 0],
    [-g, +1 / g, 0],
    [-g, -1 / g, 0]
  ], points = concat(rect1, rect2, rect3, rect4, rect5), faces = [
    [13, 12, 1, 10, 3],
    [12, 0, 16, 17, 1],
    [12, 13, 2, 8, 0],
    [13, 3, 19, 18, 2],
    [3, 10, 11, 7, 19],
    [1, 17, 5, 11, 10],
    [0, 8, 9, 4, 16],
    [2, 18, 6, 9, 8],
    [18, 19, 7, 15, 6],
    [11, 5, 14, 15, 7],
    [17, 16, 4, 14, 5],
    [9, 6, 15, 14, 4]
  ])
    [points, faces];
