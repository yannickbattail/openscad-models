smooth = false;

smoothSize = 3; // [0:8]

smoothRez = 5; // [4:50]

modelName = 1; // [0:reindeer, 1:t-rex, 2:rabit1, 3:rabit2]

/* [Animation] */
// resolution
$fn = 5;

/* [Animation] */
// rotating animation
animation_rotation = false;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated?[0, 0, 0]:$vpt;
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:$vpr;  // animation rotate around the object
$vpd = is_animated?200:$vpd;

models = [
    ["images/reindeer_front.svg", "images/reindeer_side.svg", ""],
    ["", "images/t-rex_side.svg", "images/t-rex_top.svg"],
    ["images/rabit1_front.svg", "images/rabit1_side.svg", ""],
    ["images/rabit2_front.svg", "images/rabit2_side.svg", "images/rabit2_top.svg"]

];

if (smooth) {
    minkowski() {
        threeSides(models[modelName]);
        sphere(smoothSize, $fn = smoothRez);
    }
} else {
    threeSides(models[modelName]);
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
