/*
$fn = 100;
debugColision() {
    cube();
    cylinder();
}
debugAxes();
*/

module debugAxis() {
  color("red") cube([1000, 1, 1]);
  color("green") cube([1, 1000, 1]);
  color("blue") cube([1, 1, 1000]);
}

module debugCollision(debug = false) {
  if (debug) {
    color("#ff0000ff")
      intersection() {
        children(0);
        children(1);
      }
    color("#0000ff40")
      children(0);
    color("#00ff0040")
      children(1);
  } else {
    children(0);
    children(1);
  }
}
