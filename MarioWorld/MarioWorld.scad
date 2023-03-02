use <bush.scad>
use <empty.scad>
use <fence.scad>
use <floor1.scad>
use <floor2.scad>
use <gumba.scad>
use <koopa.scad>
use <mario.scad>
use <piranha_plant.scad>
use <question.scad>
use <tube_bottom.scad>
use <tube_top.scad>
use <wall.scad>


// a list of theses caracters: mgkpB12e?wx0ftuTU
worldLine8 = " ";
worldLine7 = " ";
worldLine6 = " ";
worldLine5 = " ";
worldLine4 = " ";
worldLine3 = " ";
worldLine2 = "mgkpB ftT";
worldLine1 = "12e?wx0uU";

world = [
    worldLine8,
    worldLine7,
    worldLine6,
    worldLine5,
    worldLine4,
    worldLine3,
    worldLine2,
    worldLine1
];

MarioWorld(world);

module MarioWorld(world) {
  for (j = [0:len(world) - 1]) {
    translate([0, 0, 16 * (len(world) -1 - j)])
        worldLine(world[j]);
  }
}

module worldLine(line) {
  for (i = [0:len(line) - 1]) {
    translate([16 * i, 0, 0])
        tile(line[i]);
  }
}


module tile(tileType) {
  if (tileType == "m") { mario(); }
  else if (tileType == "g") { gumba(); }
  else if (tileType == "k") { koopa(); }
  else if (tileType == "p") { piranha_plant(); }
  else if (tileType == "B") { bush(); }
  else if (tileType == "T") { tube_top(); }
  else if (tileType == "U") { tube_bottom(); }
  else if (tileType == "t") { small_tube_top(); }
  else if (tileType == "u") { small_tube_bottom(); }
  else if (tileType == "f") { fence(); }
  else if (tileType == "1") { floor1(); }
  else if (tileType == "2") { floor2(); }
  else if (tileType == "e") { empty(); }
  else if (tileType == "q") { question(); }
  else if (tileType == "?") { question(); }
  else if (tileType == "w") { wall(); }
  else if (tileType == "x") { tileFull(); }
  else if (tileType == "0") { tileHollow(); }
}

module small_tube_top() {
  translate([0,-8,8]) scale(0.5) tube_top();
  translate([0,-8,0]) scale(0.5) tube_bottom();
}

module small_tube_bottom() {
translate([0,-8,0]) scale([0.5,0.5,1]) tube_bottom();
}


module tileFull() {
  translate([0,-16,0])
    cube(16);
}

module tileHollow() {
  translate([0,-16,0]) {
      translate([ 0, 0, 0]) cube([16,1,1]);
      translate([ 0, 0,15]) cube([16,1,1]);
      translate([ 0,15, 0]) cube([16,1,1]);
      translate([ 0,15,15]) cube([16,1,1]);
      
      translate([ 0, 0, 0]) cube([1,16,1]);
      translate([ 0, 0,15]) cube([1,16,1]);
      translate([15, 0, 0]) cube([1,16,1]);
      translate([15, 0,15]) cube([1,16,1]);
      
      translate([ 0, 0, 0]) cube([1,1,16]);
      translate([ 0,15 ,0]) cube([1,1,16]);
      translate([15, 0, 0]) cube([1,1,16]);
      translate([15,15, 0]) cube([1,1,16]);
      
  }
}
