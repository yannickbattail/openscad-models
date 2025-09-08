// size of the knot
size = 10;

// step every degree, less is more points and moother curve but longer to compute
step = 3;

// use sphere as dot else cube
useSphere = true;

// sphere or cube size
sphereSize = 1;

// use hull() to smooth the curve
useHull = true;

// sphere resolution
$fn = 50;

Trefoil_knot() {
  if (useSphere) {
    sphere(sphereSize);
  } else {
    cube(sphereSize);
  }
}

module Trefoil_knot() {
  for(i = [0:step:360 - step]) {
    if (useHull) {
      hull() {
        dot(i) {
          children(0);
        }
        dot(i + step) {
          children(0);
        }
      }
    } else {
      dot(i) {
        children(0);
      }
    }
  }
}

// 2 stroke infinity symbol
// https://en.wikipedia.org/wiki/Lemniscate_of_Bernoulli
// https://en.wikipedia.org/wiki/Trefoil_knot

function trefoil_knot(angle) =
  [size / 2 * (sin(angle) + 2 * sin(2 * angle)), size / 2 * (cos(angle) - 2 * cos(2 * angle)), size / 2 * (-sin(3 * angle))];


module dot(angle) {
  translate(trefoil_knot(angle))
    children(0);
}
