include <pipe1.scad>

/* [Animation] */
// Animation rotation
animation_rotation = false;

/* [Hidden] */
$vpt = animation_rotation?[4, 3, 120]:$vpt;
$vpr = animation_rotation?[60, 0, 365 * $t]:$vpr; // animation rotate around the object
$vpd = animation_rotation?2000:$vpd;

$fn=100;

paperclip();
example();
//random_pipe();

module example(){
    //   outer_radius, inner_radius, list of segments
    pipe(10,           7,           [
        //length,rotation,angle,radius_of_curvature 
        [    200,       0,   90,    10],
        [    120,      90,  120,    20],
        [    100,       0,  120,    20],
        [     60,       0,    0,    20]
    ]);
    
    color("white")
    rotate([180, 0, 0])
    pipe(14,          10,           [
        //length,rotation,angle,radius_of_curvature 
        [     60,     180,   90,     0],
        [     60,      90,    0,    20]
    ]);

}

// example paperclip
module paperclip() {
    color("gray")
    translate([100, 0, 60])
    pipe(10, 9, [
        //length,rotation,angle,radius_of_curvature 
        [    500,       0,   90,    70],
        [    140,       0,   90,    70],
        [    550,      10,   90,    30],
        [    120,       0,   90,    30],
        [    400,      10,   90,    50],
        [    100,       0,   90,    50],
        [    360,      10,    0,    50],
    ]);
}


module random_pipe() {
    //segments = [ for (a = [0 : 400]) [ 50, rands(0, 360, 1)[0], 90, 10 ] ];
    segments = [ for (a = [0 : 400]) [ rands(40, 100, 1)[0], rands(0, 360, 1)[0], rands(30, 160, 1)[0], 0 ] ];
    //echo(str("segments = ", segments));
    pipe(10, 9, segments);
}
