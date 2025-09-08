use <lib/wrapAroundCylinder.scad>
use <lib/surfaceData.scad>
use <lib/mug.scad>
//include <mandalorian_symbol.scad>
//include <redPanda.scad>
include <werefox.scad>

imageAngle = 90;
reliefMultipier = 20;


/* [Hidden] */
/* constants */
IMAGE_WIDTH=0;
IMAGE_HEIGHT=1;
IMAGE_PIXELS=2;
POINTS=0;
FACES=1;

s = surfaceDataf(image[IMAGE_PIXELS]);

//points = s[POINTS];
points = wrapAroundCylinder(s[POINTS], imageAngle, image[IMAGE_WIDTH], image[IMAGE_HEIGHT], reliefMultipier);

polyhedron(points = points, faces = s[FACES]);
