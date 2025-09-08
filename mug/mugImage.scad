use <lib/wrapAroundCylinder.scad>
use <lib/surfaceData.scad>
use <lib/mug.scad>
//include <images/redPanda.scad>
//include <images/werefox.scad>
include <images/cat.scad>


/* [Mug] */
// Height of the cup in mm
mugHeight = 115;
// Major radius of the cup in mm.
mugDiameter = 41;
// Width of the wall  in mm.
mugWall = 4;
// Thickness of handle in mm.
mugHandleThickness = 5.25;
// Rounding of the bottom, radius in mm.
mugRounding = 10;

/* [Image] */
imageAngle = 90;
reliefMultipier = 5;
// image data from imageToMatrix.html 
inlineImage = []; // 

/* [Resolution] */
// "Fragments" or fineness. Higher = smoother
$fn = 60;

/* [Hidden] */
/* constants. Do not change them */
IMAGE_WIDTH = 0;
IMAGE_HEIGHT = 1;
IMAGE_PIXELS = 2;
POINTS = 0;
FACES = 1;

imageData = len(inlineImage) != 0 ? inlineImage : image;

polygoneSurface = surfaceDataf(imageData[IMAGE_PIXELS]);

//points = polygoneSurface[POINTS];
points = wrapAroundCylinder(polygoneSurface[POINTS], [imageData[IMAGE_WIDTH], imageData[IMAGE_HEIGHT]], mugDiameter, mugHeight, imageAngle, reliefMultipier);

mug(mugRounding, mugHeight, mugDiameter, mugWall, mugHandleThickness);

polyhedron(points = points, faces = polygoneSurface[FACES]);
