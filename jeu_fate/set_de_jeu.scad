// piece
part = "tout"; // [tout, par_element, par_forme]
element = "red"; // [red:feu, yellow:air, green:terre, blue:eau, DarkSlateGray:jeton noir, white:jeton blanc, gray:corner gris]
forme = "octogonal"; // [rond, carre, octogonal, jeton, corner]

// width
width = 24 ; // [20:1:30]

// size of the model
thickness = 5; // [3:1:10]

// tolerence
tolerence = 0.4; // [0.05:0.05:2]

// cavity
cavity = 17 ; // [1:1:25]

// resolution
$fn = 100;

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated?[0, 0, 0]:$vpt;
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:$vpr;  // animation rotate around the object
$vpd = is_animated?1000:$vpd;
// constant epsilon
EPSI = 0.001;

use <fate.scad>;

if (part == "tout") {
  tout(width, thickness, tolerence, cavity);
} else if (part == "par_element") {
  par_element(thickness, tolerence, element);
} else if (part == "par_forme") {
  par_forme(thickness, tolerence, forme);
} else {
  assert(false, "unknown part");
}

module tout(width, thickness, tolerence, cavity) {
  translate([0 * 128 + 2, 0 * 128 + 2, 0])
    par_element(thickness, tolerence, "red"); // feu
  translate([1 * 128 + 2, 0 * 128 + 2, 0])
    par_element(thickness, tolerence, "yellow"); // air
  translate([0 * 128 + 2, 1 * 128 + 2, 0])
    par_element(thickness, tolerence, "green"); // terre
  translate([1 * 128 + 2, 1 * 128 + 2, 0])
    par_element(thickness, tolerence, "blue"); // eau
  translate([0 * 128 + 2, 2 * 128 + 2, 0])
    par_element(thickness, tolerence, "DarkSlateGray"); // jeton noir
  translate([1 * 128 + 2, 2 * 128 + 2, 0])
    par_element(thickness, tolerence, "white"); // jeton blanc
  translate([1 * 128 + 2, 3 * 128 + 20, 0])
    par_element(thickness, tolerence, "gray"); // corner
}

module par_element(thickness, tolerence, element) {
  color(element) {
    if (element == "white" || element == "DarkSlateGray") {
      espacement = cavity + 2; // 10 is the size of the piece, 2 is the space between pieces
      colonne(espacement, 7)
      ligne(espacement, 5)
      jeton(width, thickness, tolerence, cavity);
    } else if (element == "gray") {
      espacement = width + 2; // 30 is the size of the piece, 2 is the space between pieces
      colonne(espacement, 2)
      ligne(espacement, 2)
      corner(width, thickness, tolerence, cavity);
    } else {
      espacement = width + 2; // 30 is the size of the piece, 2 is the space between pieces
      translate([0, 0 * espacement, 0])
        ligne(espacement, 4)
        rond(width, thickness, tolerence, cavity);
      translate([0, 1 * espacement, 0])
        ligne(espacement, 4)
        carre(width, thickness, tolerence, cavity);
      translate([0, 2 * espacement, 0])
        ligne(espacement, 4)
        octogonal(width, thickness, tolerence, cavity);
      translate([0, 3 * espacement, 0])
        ligne(espacement, 4)
        octogonal(width, thickness, tolerence, cavity);
    }
  }
}

module par_forme(thickness, tolerence, forme) {
  elementColors = ["red", "yellow", "green", "blue", "DarkSlateGray", "white"];
  if (forme == "rond") {
    espacement = width + 2; // 30 is the size of the piece, 2 is the space between pieces
    colonneColor(espacement, 4, elementColors)
    ligne(espacement, 4)
    rond(width, thickness, tolerence, cavity);
  } else if (forme == "carre") {
    espacement = width + 2; // 30 is the size of the piece, 2 is the space between pieces
    colonneColor(espacement, 4, elementColors)
    ligne(espacement, 4)
    carre(width, thickness, tolerence, cavity);
  } else if (forme == "octogonal") {
    espacement = width + 2; // 30 is the size of the piece, 2 is the space between pieces
    colonneColor(espacement, 4, elementColors)
    ligne(espacement, 8)
    octogonal(width, thickness, tolerence, cavity);
  } else if (forme == "jeton") {
    espacement = cavity + 2; // 10 is the size of the piece, 2 is the space between pieces
    color("DarkSlateGray")
      colonne(espacement, 7)
      ligne(espacement, 5)
      jeton(width, thickness, tolerence, cavity);
    color("white")
      translate([5 * espacement, 0, 0])
        colonne(espacement, 7)
        ligne(espacement, 5)
        jeton(width, thickness, tolerence, cavity);
  } else if (forme == "corner") {
    espacement = width + 2; // 30 is the size of the piece, 2 is the space between pieces
    color("gray")
      colonne(espacement, 2)
      ligne(espacement, 2)
      corner(width, thickness, tolerence, cavity);
  } else {
    assert(false, "unknown forme");
  }
}

module colonneColor(espacement, nombre, colorNames) {
  for (i = [0 : nombre - 1]) {
    translate([0, i * espacement, 0])
      color(colorNames[i])
        children(0);
  }
}

module colonne(espacement, nombre) {
  for (i = [0 : nombre - 1]) {
    translate([0, i * espacement, 0])
      children(0);
  }
}


module ligne(espacement, nombre) {
  for (i = [0 : nombre - 1]) {
    translate([i * espacement, 0, 0])
      children(0);
  }
}
