use <wrapAroundCylinder.scad>
use <surfaceData.scad>
use <mug.scad>
use <nutellaGlass.scad>
/* Images */
include <images/cat.scad>
include <images/cat_fur.scad>
include <images/cat_profile.scad>
include <images/cat_face.scad>
include <images/red_panda.scad>
include <images/werefox.scad>
include <images/mountain.scad>
include <images/moon.scad>
include <images/jedi_sith.scad>
include <images/solo_carbonite.scad>
include <images/yoda.scad>
include <images/mountain_lake.scad>

part = "cat"; // [cat, cat_fur, cat_profile, cat_face, red_panda, werefox, mountain, moon, jedi_sith, solo_carbonite, yoda, mountain_lake]

/* [Mug] */
// height of the mug
mugHeight = 80; // [70:92]
// external radius of the mug
mugDiameter = 80; // [75:100]
// mug thickness (Width of the wall)
mugThickness = 4;
// make a mug compatible with nutella glass
withNutellaGlass = true;
// Number of block
numberOfBlock = 0; // [0:none, 3:3, 4:4, 5:5, 6:6]

/* [Image] */
// image display angle
imageAngle = 90; // [10:360]
// image rotation angle
imageRotation = 45; // [0:360]
// relief multipier (by default relief is between 0 and 1)
reliefMultipier = 2;
// image data from imageToMatrix.html 
inlineImage = []; //
// show only image or mug (for debug purpose and faster preview)
partialModel = "all"; // [all, image_only, mug_only]

/* [Animation] */
// rotating animation
animation_rotation = false;

$fn = 100;

/* [Hidden] */
is_animated = animation_rotation;
$vpt = is_animated?[0, 0, 0]:[];
$vpr = is_animated?[60, 0, animation_rotation?(365 * $t):45]:[]; // animation rotate around the object
$vpd = is_animated?500:[];

function selectImage() =
    (part == "cat")?image_cat:
            (part == "cat_fur")?image_cat_fur:
                    (part == "cat_profile")?image_cat_profile:
                            (part == "cat_face")?image_cat_face:
                                    (part == "red_panda")?image_red_panda:
                                            (part == "werefox")?image_werefox:
                                                    (part == "mountain")?image_mountain:
                                                            (part == "moon")?image_moon:
                                                                    (part == "jedi_sith")?image_jedi_sith:
                                                                            (part == "solo_carbonite")?
                                                                            image_solo_carbonite:
                                                                                    (part == "yoda")?image_yoda:
                                                                                            (part == "mountain_lake")?
                                                                                            image_mountain_lake:[];

imageData = len(inlineImage) > 0 ? inlineImage : selectImage();

if (len(inlineImage) > 0) {
    echo("use inline image data (customizer)");
} else {
    echo("use image data from file");
}

epsi = 0.01; // epsilon

rotate([0, 0, 180]) mugImage(mugHeight, mugDiameter / 2, mugThickness, withNutellaGlass, imageAngle, imageRotation,
reliefMultipier, imageData, partialModel, numberOfBlock);

module mugImage(mugHeight, mugRadius, mugThickness, withNutellaGlass, imageAngle, imageRotation, reliefMultipier,
imageMatrix, partialModel = "all", numberOfBlock) {
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
                nutellaGlass(plain = true, nbBlock = numberOfBlock);
        } else {
            translate([0, 0, mugThickness]) {
                cylinder(h = mugHeight - mugThickness + epsi, r = mugRadius - mugThickness);
                // + epsi to prevent display bug
            }
        }
    }
}

module imageMatrixOnCylinder(height, radius, imageAngle, reliefMultipier, imageMatrix) {
    /* constants. Do not change them */
    POINTS = 0;
    FACES = 1;

    polygonSurface = surfaceDataf(imageMatrix);

    //points = polygonSurface[POINTS];
    points = wrapAroundCylinder(polygonSurface[POINTS], [len(imageMatrix[0]), len(imageMatrix)], radius,
    height, imageAngle, reliefMultipier);

    polyhedron(points = points, faces = polygonSurface[FACES]);
}
