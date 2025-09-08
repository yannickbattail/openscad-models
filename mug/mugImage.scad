use <lib/wrapAroundCylinder.scad>
use <lib/surfaceData.scad>
use <lib/mug.scad>
//include <images/redPanda.scad>
//include <images/werefox.scad>
//include <images/cat.scad>
include <images/cat_fur.scad>

/* [Mug] */
// height of the nug
mugHeight = 100;
// external radius of the mug
mugDiameter = 80;
// mug thickness (Width of the wall)
mugThickness = 5;

/* [Image] */
// image display angle
imageAngle = 90; // [10:360]
// image rotation angle
imageRotation = 45; // [0:360]
// relief multipier (by default relief is between 0 and 1)
reliefMultipier = 2;
// image data from imageToMatrix.html 
inlineImage = []; //

/* [Details] */
$fn = 100;

/* [Hidden] */
imageData = len(inlineImage) > 0 ? inlineImage : image;

if (len(inlineImage) > 0) {
    echo("use inline image data (customizer)");
} else {
    echo("use image data from file");
}

mugImage(mugHeight, mugDiameter / 2, mugThickness, imageAngle, imageRotation, reliefMultipier, imageData);

module mugImage(mugHeight, mugRadius, mugThickness, imageAngle, imageRotation, reliefMultipier, imageMatrix) {
    mug(mugHeight, mugRadius, mugThickness);

    render() // preview display nothing without this 
        difference() {
            rotate([0, 0, imageRotation]) {
                imageMatrixOnCylinder(mugHeight, mugRadius, imageAngle, reliefMultipier, imageMatrix);
            }
            cylinder(h = mugHeight, r = mugRadius - mugThickness);
        }
}

module imageMatrixOnCylinder(height, radius, imageAngle, reliefMultipier, imageMatrix) {
    /* constants. Do not change them */
    POINTS = 0;
    FACES = 1;

    polygoneSurface = surfaceDataf(imageMatrix);

    //points = polygoneSurface[POINTS];
    points = wrapAroundCylinder(polygoneSurface[POINTS], [len(imageMatrix[0]), len(imageMatrix)], radius,
    height, imageAngle, reliefMultipier);

    polyhedron(points = points, faces = polygoneSurface[FACES]);
}
