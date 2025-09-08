use <lib/wrapAroundCylinder.scad>
use <lib/surfaceData.scad>
use <lib/mug.scad>
//include <redPanda.scad>
include <werefox.scad>


/* [Mug] */
// Rounding of the bottom, radius in mm.
cornd = 10;
// Height of the cup in mm
ovrht = 115;
// Major radius of the cup in mm.
cupwd = 41;
// Width of the wall  in mm.
cupwal = 4;
// Thickness of handle in mm.
handlr = 5.25;

/* [Image] */
imageDiameter = 100;
imageAngle = 90;
reliefMultipier = 20;
// image data from imageToMatrix.html 
inlineImage = []; // 

/* [Resolution] */
// "Fragments" or fineness. Higher = smoother
$fn = 60;

/* [Hidden] */
/* constants. Do not change them */
IMAGE_WIDTH=0;
IMAGE_HEIGHT=1;
IMAGE_PIXELS=2;
POINTS=0;
FACES=1;


cornerd = min(cornd, cupwd / 2); // Bad things happen if you try to round the bottom too much!
cupht = ovrht - cornerd - cupwal * .5; // cup height adjusted for other features

imageData = len(inlineImage) != 0 ? inlineImage : image;

s = surfaceDataf(imageData[IMAGE_PIXELS]);

//points = s[POINTS];
points = wrapAroundCylinder(s[POINTS], imageDiameter, imageAngle, imageData[IMAGE_WIDTH], imageData[IMAGE_HEIGHT], reliefMultipier);

polyhedron(points = points, faces = s[FACES]);
