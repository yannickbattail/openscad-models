use <lib/wrapAroundCylinder.scad>
use <lib/surfaceData.scad>
use <lib/mug.scad>
//include <images/redPanda.scad>
//include <images/werefox.scad>
include <images/cat.scad>

/* [Mug] */
// height of the nug
mugHeight = 100;
// external radius of the mug
mugDiameter = 50;
// mug thickness (Width of the wall)
mugThickness = 5;

/* [Image] */
// image display angle
imageAngle = 90; // [10:360]
// image rotation angle
imageRotation = 5; // [0:360]
// relief multipier (by default relief is between 0 and 1)
reliefMultipier = 5;
// image data from imageToMatrix.html 
inlineImage = []; //

/* [Hidden] */
imageData = len(inlineImage) != 0 ? inlineImage : image;

mugImage(mugHeight, mugDiameter, mugThickness, imageAngle, imageRotation, reliefMultipier, imageData);

module mugImage(mugHeight, mugDiameter, mugThickness, imageAngle, imageRotation, reliefMultipier, imageData) {
    mug(mugHeight, mugDiameter, mugThickness);

    render() // preview display nothing without this 
        difference() {
            rotate([0, 0, imageRotation]) {
                imageOnCyinder(mugHeight, mugDiameter, imageAngle, reliefMultipier, imageData);
            }
            cylinder(h = mugHeight, r = mugDiameter - mugThickness);
        }
}

module imageOnCyinder(mugHeight, mugDiameter, imageAngle, reliefMultipier, imageData) {

    /* constants. Do not change them */
    IMAGE_WIDTH = 0;
    IMAGE_HEIGHT = 1;
    IMAGE_PIXELS = 2;
    POINTS = 0;
    FACES = 1;
    
    polygoneSurface = surfaceDataf(imageData[IMAGE_PIXELS]);

    //points = polygoneSurface[POINTS];
    points = wrapAroundCylinder(polygoneSurface[POINTS], [imageData[IMAGE_WIDTH], imageData[IMAGE_HEIGHT]], mugDiameter,
    mugHeight, imageAngle, reliefMultipier);
    
    polyhedron(points = points, faces = polygoneSurface[FACES]);
}
