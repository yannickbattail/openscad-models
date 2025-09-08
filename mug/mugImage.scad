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
// make a mug compatible with nutella glass
withNutellaGlass = true;

/* [Image] */
// image display angle
imageAngle = 360; // [10:360]
// image rotation angle
imageRotation = 0; // [0:360]
// relief multipier (by default relief is between 0 and 1)
reliefMultipier = 3;
// image data from imageToMatrix.html 
inlineImage = []; //
// show only image or mug (for debug purpose and faster preview)
partialModel = "all"; // [all, image_only, mug_only]

/* [Details] */
$fn = 100;

/* [Hidden] */
imageData = len(inlineImage) > 0 ? inlineImage : image;

if (len(inlineImage) > 0) {
    echo("use inline image data (customizer)");
} else {
    echo("use image data from file");
}

epsi = 0.01; // epsilon

mugImage(mugHeight, mugDiameter / 2, mugThickness, withNutellaGlass, imageAngle, imageRotation, reliefMultipier, imageData, partialModel);

module mugImage(mugHeight, mugRadius, mugThickness, withNutellaGlass, imageAngle, imageRotation, reliefMultipier, imageMatrix, partialModel = "all") {

    difference() {
        render() // preview display nothing without this
            union() {
                if (partialModel != "image_only") {
                    mug(mugHeight, mugRadius, mugThickness);
                }
                if (partialModel != "mug_only") {
                    rotate([0, 0, imageRotation]) {
                        imageMatrixOnCylinder(mugHeight, mugRadius, imageAngle, reliefMultipier, imageMatrix);
                    }
                }
            }
        if (withNutellaGlass) {
            translate([0, 0, mugThickness])
                #nutellaGlass();
        } else {
            translate([0, 0, mugThickness]) {
                cylinder(h = mugHeight - mugThickness + epsi, r = mugRadius - mugThickness); // + epsi to prevent display bug
            }
        }
    }
}

module nutellaGlass() {
    // total height 92
    translate([0, 0, 25])
        difference() {
            union() {
                cylinder(d1 = 69.5, d2 = 73.5, h = 67);
                sphere(d = 69.5);
            }
            translate([0, 0, - 40 - 25])
                cube([80, 80, 80], center = true);
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
