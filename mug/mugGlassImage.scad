use <lib/wrapAroundCylinder.scad>
use <lib/surfaceData.scad>
use <lib/mug.scad>
/* Images */
include <images/cat.scad>
//include <images/cat_fur.scad>
//include <images/cat_profile.scad>
//include <images/cat_face.scad>
//include <images/redPanda.scad>
//include <images/werefox.scad>
/* [Mug] */
// height of the nug
mugHeight = 80; // [70:92]
// external radius of the mug
mugDiameter = 80; // [75:100]
// mug thickness (Width of the wall)
mugThickness = 4;

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
    difference() {
        render() // preview display nothing without this
        union() {
            mug(mugHeight, mugRadius, mugThickness, true);
            rotate([0, 0, imageRotation]) {
                imageMatrixOnCylinder(mugHeight, mugRadius, imageAngle, reliefMultipier, imageMatrix);
            }
        }
        translate([0,0,mugThickness])
        #nutellaGlass2();
    }
}
module nutellaGlass2() {
    // total height 92
    translate([0,0,25])
    difference() {
        union() {
            cylinder(d1 = 69, d2 = 73, h = 67);
            sphere(d = 69);
        }
        translate([0,0,-40-25])
            cube([80,80,80], center=true);
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
