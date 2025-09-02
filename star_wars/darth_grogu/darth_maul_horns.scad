// name of the horns (north south est west center)
horn_name = "all"; // [all, n, c, s, w, e, nw, ne, sw, se]
debug = false;

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated?[0, 0, 0]:$vpt;
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:$vpr;  // animation rotate around the object
$vpd = is_animated?150:$vpd;

if (horn_name == "all") {
  all_horns();
} else {
  horns_by_name(horn_name);
}

/*
name of the horns (north south est west center)
 nw  n  ne
 w   c   e
  sw   se
     s
*/
horns_map = object(
n = object(translation = [94, 125, 0], cube_size = [40, 50, 50], position = [0, 3, 0]),
c = object(translation = [95, 79, 0], cube_size = [40, 45, 50], position = [0, 2, 0]),
s = object(translation = [100, 10, 0], cube_size = [28, 40, 50], position = [0, 0, 0]),
w = object(translation = [34, 61, 0], cube_size = [35, 32, 50], position = [-1, 2, 0]),
e = object(translation = [157, 61, 0], cube_size = [35, 32, 50], position = [1, 2, 0]),
nw = object(translation = [39, 123, 0], cube_size = [40, 36, 50], position = [-1, 3, 0]),
ne = object(translation = [147, 121, 0], cube_size = [46, 36, 50], position = [1, 3, 0]),
sw = object(translation = [59, 24, 0], cube_size = [36, 40, 50], position = [-1, 1, 0]),
se = object(translation = [132, 29, 0], cube_size = [36.9, 34.7, 50], position = [1, 1, 0])
);

module all_horns() {
  for (key = horns_map) {
    translate(horns_map[key].position * 50)
      horn(horns_map[key]);
  }
}

module horns_by_name(horn_name) {
  horn(horns_map[horn_name]);
}

module horn(horns_object) {
  if (!debug) {
    translate([-horns_object.cube_size[0] / 2, -horns_object.cube_size[1] / 2, 0]) {// center it (not on z)
      translate(-horns_object.translation) {// translate to 0,0,0
        intersection() {
          import("darth_maul_horns.3mf");
          translate(horns_object.translation) {
            cube(horns_object.cube_size);
          }
        }
      }
    }
  } else {
    import("darth_maul_horns.3mf");
    translate(horns_object.translation) {
      #cube(horns_object.cube_size);
    }
  }
}
