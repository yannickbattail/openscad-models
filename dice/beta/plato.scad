// from https://github.com/qalle2/plato
// GNU General Public License v3.0

// The non-built-in Platonic solids.
// See the readme file for the math. https://github.com/qalle2/plato/blob/main/README.md

// demo
//translate([-2, -2]) tetrahedron();
//translate([ 2, -2]) octahedron();
//translate([-2,  2]) dodecahedron();
//translate([ 2,  2]) icosahedron();

module tetrahedron() {
  // regular tetrahedron (centered at origin, edge length 1)

  he = 1 / 2; // half the edge length
  fi = sqrt(3) / 6; // faces - incircle radius
  fc = sqrt(3) / 3; // faces - circumcircle radius
  i = sqrt(6) / 12; // insphere radius
  c = sqrt(6) / 4; // circumsphere radius

  polyhedron(
  // vertices
  [
    [0, 0, c], // 0: top
    [0, fc, -i], // 1: bottom front
    [-he, -fi, -i], // 2: bottom rear left
    [he, -fi, -i], // 3: bottom rear right
  ], 
  // faces
  [
    [0, 1, 3], // right
    [0, 2, 1], // left
    [0, 3, 2], // rear
    [1, 2, 3], // bottom
  ]);
}

module octahedron() {
  // regular octahedron (centered at origin, edge length 1)

  he = 1 / 2; // half the edge length
  c = sqrt(2) / 2; // circumsphere radius

  polyhedron(
  // vertices
  [
    [0, 0, c], // 0: top
    [-he, he, 0], // 1: front left
    [he, he, 0], // 2: front right
    [he, -he, 0], // 3: rear right
    [-he, -he, 0], // 4: rear left
    [0, 0, -c], // 5: bottom
  ], 
  // faces
  [
    [0, 1, 2], // top front
    [0, 2, 3], // top right
    [0, 3, 4], // top rear
    [0, 4, 1], // top left
    [1, 5, 2], // bottom front
    [2, 5, 3], // bottom right
    [3, 5, 4], // bottom rear
    [1, 4, 5], // bottom left
  ]);
}

module dodecahedron() {
  // regular dodecahedron (centered at origin, edge length 1)

  // coordinates of the "cube"
  c = (1 + sqrt(5)) / 4; // phi / 2
  // coordinates of the "rectangular cuboid"
  r1 = 0;
  r2 = (3 + sqrt(5)) / 4; // (phi + 1) / 2
  r3 = 1 / 2;

  polyhedron(
  // vertices
  [
    [r1, r2, r3], //  0: front top
    [r1, r2, -r3], //  1: front bottom
    [r1, -r2, r3], //  2: rear top
    [r1, -r2, -r3], //  3: rear bottom
    [r3, r1, r2], //  4: top right
    [r3, r1, -r2], //  5: bottom right
    [-r3, r1, r2], //  6: top left
    [-r3, r1, -r2], //  7: bottom left
    [c, c, c], //  8: top front right
    [c, c, -c], //  9: bottom front right
    [c, -c, c], // 10: top rear right
    [c, -c, -c], // 11: bottom rear right
    [-c, c, c], // 12: top front left
    [-c, c, -c], // 13: bottom front left
    [-c, -c, c], // 14: top rear left
    [-c, -c, -c], // 15: bottom rear left
    [r2, r3, r1], // 16: right front
    [r2, -r3, r1], // 17: right rear
    [-r2, r3, r1], // 18: left front
    [-r2, -r3, r1], // 19: left rear
  ], 
  // faces
  [
    [0, 1, 9, 16, 8], // front right
    [0, 8, 4, 6, 12], // top front
    [0, 12, 18, 13, 1], // front left
    [1, 13, 7, 5, 9], // bottom front
    [2, 3, 15, 19, 14], // rear left
    [2, 10, 17, 11, 3], // rear right
    [2, 14, 6, 4, 10], // top rear
    [3, 11, 5, 7, 15], // bottom rear
    [4, 8, 16, 17, 10], // right top
    [5, 11, 17, 16, 9], // right bottom
    [6, 14, 19, 18, 12], // left top
    [7, 13, 18, 19, 15], // left bottom
  ]);
}

module icosahedron() {
  // regular icosahedron (centered at origin, edge length 1)

  c1 = 0; // coordinate 1
  c2 = 1 / 2; // coordinate 2
  c3 = (1 + sqrt(5)) / 4; // coordinate 3; phi / 2

  polyhedron(
  // vertices
  [
    [c3, c1, c2], //  0: right top
    [c3, c1, -c2], //  1: right bottom
    [-c3, c1, c2], //  2: left top
    [-c3, c1, -c2], //  3: left bottom
    [c2, c3, c1], //  4: front right
    [c2, -c3, c1], //  5: rear right
    [-c2, c3, c1], //  6: front left
    [-c2, -c3, c1], //  7: rear left
    [c1, c2, c3], //  8: top front
    [c1, c2, -c3], //  9: bottom front
    [c1, -c2, c3], // 10: top rear
    [c1, -c2, -c3], // 11: bottom rear
  ], 
  // faces
  [
    [0, 1, 5], // right rear
    [0, 4, 1], // right front
    [0, 5, 10], // top rear right
    [0, 8, 4], // top front right
    [0, 10, 8], // top right
    [1, 4, 9], // bottom front right
    [1, 9, 11], // bottom right
    [1, 11, 5], // bottom rear right
    [2, 3, 6], // left front
    [2, 6, 8], // top front left
    [2, 7, 3], // left rear
    [2, 8, 10], // top left
    [2, 10, 7], // top rear left
    [3, 7, 11], // bottom rear left
    [3, 9, 6], // bottom front left
    [3, 11, 9], // bottom left
    [4, 6, 9], // front bottom
    [4, 8, 6], // front top
    [5, 7, 10], // rear top
    [5, 11, 7], // rear bottom
  ]);
}
