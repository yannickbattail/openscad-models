$fn=50;
union(){
    rotate([0,0,0])   pastaWall();
    rotate([90,0,0])  pastaWall(); 
    rotate([0,-90,0]) pastaWall();

    translate([0,0,100]) rotate([0,0,0])   pastaWall();
    translate([0,100,0]) rotate([90,0,0])  pastaWall(); 
    translate([100,0,0]) rotate([0,-90,0]) pastaWall();
    cube([100,100,100]);
}
module pastaWall() {
    for (x=[5:20:90]) {
        for (y=[5:20:90]) {
            translate([x,y,0])
            //rotate(rands(0, 360, 1)[0])
            pasta();
        }
    }
}

module pasta(R=10, r=3, e=1) {
  difference() {
      rotate_extrude(angle=120) translate([R,0,0]) circle(r);
      rotate_extrude(angle=220) translate([R,0,0]) circle(r-e);
  }
}