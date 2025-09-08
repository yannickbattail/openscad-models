// model
part = 1; // [0:reindeer, 1:t-rex, 2:rabbit1, 3:rabbit2]
// smooth model, (it takes a long time to render)
smooth = false;
// smooth model size (inflate the model to make it more smooth)
smoothSize = 3; // [0:8]
// smooth resolution (the higher the number, the longer it takes to render)
smoothRez = 5; // [4:50]

/* [Animation] */
// resolution
$fn = 5;

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated ? [0, 0, 0] : $vpt;
$vpr = is_animated ? [60, 0, animation_rotation ? (365 * $t) : 45] : $vpr; // animation rotate around the object
$vpd = is_animated ? 200 : $vpd;

models = [
  ["images/reindeer_front.svg", "images/reindeer_side.svg", ""],
  ["", "images/t-rex_side.svg", "images/t-rex_top.svg"],
  ["images/rabbit1_front.svg", "images/rabbit1_side.svg", ""],
  ["images/rabbit2_front.svg", "images/rabbit2_side.svg", "" /*"images/rabbit2_top.svg"*/
  ]
];

if (smooth) {
  minkowski() {
    threeSides(models[part]);
    sphere(smoothSize, $fn = smoothRez);
  }
} else {
  threeSides(models[part]);
}

module threeSides(model) {
  intersection() {
    if (model[0] != "") {
      echo("front", model[0]);
      #rotate([90, 0, 90])
        #linear_extrude(200, center = true)
          import(model[0]);
    }
    if (model[1] != "") {
      echo("side", model[1]);
      #rotate([90, 0, 0])
        linear_extrude(200, center = true)
          import(model[1]);
    }
    if (model[2] != "") {
      echo("top", model[2]);
      #rotate([0, 0, 0])
        linear_extrude(200, center = true)
          import(model[2]);
    }
  }
}
