$fn=200;

//color("green")
//  translate([-50, 15])
//    resize([100,100])
//      import("Medical_emblem_orig.svg");

color("#7F1617") 
union() {
  translate([-15,-10]) square([21,52]);
  translate([-40,-10]) square([45,24]);
  translate([-5,-10]) square([45,12]);
  translate([5,-35]) square([12,36]);
  translate([5,-35]) polygon([[0,0],[12,0],[0,-8]]);

  translate([15,10]) square([12,12]);
  translate([-23 ,-31]) square([12,12]);
  translate([3 ,-3]) rotate([0,0,-42]) square([3,50], center=true);
}

color("#7F1617") 
difference() {
  circle(50);
  circle(46);
}

mirror([0,1])
polygon(points=[
    [17,10], [40,10], [40,-2], [9.52047,-2], [16.7237,-10], 
    [27,-10], [27,-22], [15,-22], [15,-12.5691], [6,-2.57355], 
    [6,-42], [-15,-42], [-15,-14], [-40,-14], [-40,10], 
    [-5.32128,10], [-13.4249,19], [-23,19], [-23,31], [-11,31], 
    [-11,20.7903], [-1.28438,10], [5,10], [5,43], [17,35]
]);
