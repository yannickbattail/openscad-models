include <wrapAroundCylinder.scad>
include <surfaceData.scad>
include <mug.scad>
//include <mandalorian_symbol.scad>
include <redPanda.scad>

imageAngle = 90;
reliefMultipier = 20;


/* constants */
IMAGE_WIDTH=0;
IMAGE_HEIGHT=1;
IMAGE_PIXELS=2;
POINTS=0;
FACES=1;

s = surfaceDataf(image[IMAGE_PIXELS]);

points = s[POINTS];
faces = s[FACES];

polyhedron(s[POINTS], s[FACES]);

// newPoints = wrapAroundCylinder(points, imageAngle, image_width, reliefMultipier);

color("blue") polyhedron(points = newPoints, faces = faces);

//cylinder(r=image_width, h=image_height, center=true, $fn=100);
