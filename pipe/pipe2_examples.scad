include <pipe2.scad>

part="example"; // [example, animation_length, animation_outer_radius_start, animation_inner_radius_start, animation_outer_radius_end, animation_inner_radius_end, animation_rotation, animation_angle, animation_radius_of_curvature, animation_straight_part_color, animation_curved_part_color, bugle, mouthpiece]

/* [Animation] */
// rotating animation
animation_rotation = false;
// variables animation
animation_var = false;

/* for animation */
$vpt = animation_rotation ? [0, 0, 0]         : (animation_var? [0, 0, 180] :[]);
$vpr = animation_rotation ? [70, 0, 360 * $t] : (animation_var? [120, 0, 60]:[]);
$vpd = animation_rotation ? 5000              : (animation_var? 1000        :[]);

$fn = 100;

if (part == "example") {
    example();
} else if (part == "animation_length") {
    animation(length=$t*100+100);
} else if (part == "animation_outer_radius_start") {
    animation(outer_radius_start=$t*50+50);
} else if (part == "animation_inner_radius_start") {
    animation(inner_radius_start=$t*38+10);
} else if (part == "animation_outer_radius_end") {
    animation(outer_radius_end=$t*20+20);
} else if (part == "animation_inner_radius_end") {
    animation(inner_radius_end=$t*10+7);
} else if (part == "animation_rotation") {
    animation(rotation=$t*180);
} else if (part == "animation_angle") {
    animation(angle=$t*120);
} else if (part == "animation_radius_of_curvature") {
    animation(radius_of_curvature=$t*60);
} else if (part == "animation_straight_part_color") {
    animation(straight_part_color=str("#00", floor($t*10), "000"));
} else if (part == "animation_curved_part_color") {
    animation(curved_part_color=str("#", floor($t*10), "00000"));
} else if (part == "bugle") {
    bugle();
} else if (part == "mouthpiece") {
    mouthpiece();
} else {
    example();
}

module animation(length=200,outer_radius_start=50, inner_radius_start=47,outer_radius_end=20, inner_radius_end=17, rotation=0, angle=90, radius_of_curvature=20, straight_part_color="green", curved_part_color="red") {
    pipe([
            //length,outer_radius_start, inner_radius_start,outer_radius_end, inner_radius_end,rotation,angle,radius_of_curvature,straight_part_color,curved_part_color
            [ length,outer_radius_start, inner_radius_start,outer_radius_end, inner_radius_end,rotation,angle,radius_of_curvature,straight_part_color,curved_part_color],
            [200    , 20               , 17                , 10             , 7                , 90    , 120 , 20                , "yellow"            , "orange"],
        ]);
}

module example() {
    translate([0, 100, 0])
        pipe([
                //length,outer_radius_start, inner_radius_start,outer_radius_end, inner_radius_end,rotation,angle,radius_of_curvature,straight_part_color,curved_part_color
                [200    , 50               , 47                , 20             , 17              , 0      , 90  , 20                , "green"           , "red"],
                [200    , 20               , 17                , 10             , 7                , 90    , 120 , 20                , "blue"            , "orange"],
            ]);
}

module bugle() {
    rotate([0, 90, 0]) {
        pipe([
                //length,outer_radius_start, inner_radius_start,outer_radius_end, inner_radius_end,rotation,angle,radius_of_curvature,straight_part_color,curved_part_color
                [600    , 10               , 8                 , 14             , 12              , 90     , 90  , 100               , "orange"          , "orange"],
                [200    , 14               , 12                , 14             , 12              , 0      , 90  , 100               , "orange"          , "orange"],
                [500    , 14               , 12                , 18             , 16              , - 10   , 90  , 100               , "orange"          , "orange"],
                [200    , 14               , 12                , 18             , 16              , 0      , 90  , 100               , "orange"          , "orange"],
                [500    , 18               , 16                , 22             , 20              , 0      , 0   , 0                 , "orange"          , "orange"],
                [50     , 22               , 20                , 30             , 28              , 0      , 0   , 0                 , "orange"          , "orange"],
                [50     , 30               , 28                , 60             , 58              , 0      , 0   , 0                 , "orange"          , "orange"],
                [50     , 60               , 58                , 120            , 118             , 0      , 0   , 0                 , "orange"          , "orange"],
            ]);
    }
    mouthpiece();
}

module mouthpiece() {
    rotate([0, - 90, 0]) {
        pipe([
                //length,outer_radius_start, inner_radius_start,outer_radius_end, inner_radius_end,rotation,angle,radius_of_curvature,straight_part_color,curved_part_color
                [60     , 8                , 7                 , 9              , 8               , 0      , 0   , 0                 , "orange"          , "orange"],
                [20     , 9                , 8                 , 20             , 12              , 0      , 0   , 0                 , "orange"          , "orange"],
                [20     , 20               , 12                , 20             , 12              , 0      , 0   , 0                 , "orange"          , "orange"],
                [6      , 20               , 12                , 30             , 20              , 0      , 0   , 0                 , "orange"          , "orange"],
                [10     , 30               , 20                , 30             , 20              , 0      , 0   , 0                 , "orange"          , "orange"],
            ]);
    }
}
