use <../common/wrapAroundCylinder.scad>
use <../common/surfaceData.scad>
use <../common/mug.scad>
use <../nutellaGlass/nutellaGlass.scad>
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
include <images/denver.scad>
include <images/christmas.scad>
include <images/bicicletta.scad>
include <images/lord_of_the_jedi_potter.scad>

part = "cat"; // [cat, cat_fur, cat_profile, cat_face, red_panda, werefox, mountain, moon, jedi_sith, solo_carbonite, yoda, mountain_lake, denver, christmas, bicicletta, lord_of_the_jedi_potter]

/* [Mug] */
// height of the mug
mugHeight = 80; // [70:92]
// external radius of the mug
mugDiameter = 80; // [75:100]
// mug thickness (Width of the wall)
mugThickness = 4; // [1:1:10]
// mug with big handle that can be printed without supports
hasBigHandle = true;
// make a mug compatible with nutella glass
withNutellaGlass = true;
// Number of block
numberOfBlock = 0; // [0:none, 3:3, 4:4, 5:5, 6:6]

/* [Image] */
// image display angle
imageAngle = 90; // [10:360]
// image rotation angle
imageRotation = 45; // [0:360]
// relief multiplier (by default relief is between 0 and 1)
reliefMultiplier = 2; // [0.5:0.5:10]
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
                                        (part == "solo_carbonite")?image_solo_carbonite:
                                            (part == "yoda")?image_yoda:
                                                (part == "mountain_lake")?image_mountain_lake:
                                                    (part == "denver")?image_denver:
                                                        (part == "christmas")?image_christmas:
                                                            (part == "bicicletta")?image_bicicletta:
                                                                (part == "lord_of_the_jedi_potter")?image_lord_of_the_jedi_potter:
                                                                    [];

imageData = len(inlineImage) > 0 ? inlineImage : selectImage();

if (len(inlineImage) > 0) {
    echo("use inline image data (customizer)");
} else {
    echo("use image data from file");
}

epsi = 0.01; // epsilon

rotate([0, 0, 180]) mugImage(mugHeight, mugDiameter / 2, mugThickness, withNutellaGlass, imageAngle, imageRotation,
reliefMultiplier, imageData, partialModel, numberOfBlock, hasBigHandle);

module mugImage(mugHeight, mugRadius, mugThickness, withNutellaGlass, imageAngle, imageRotation, reliefMultiplier,
imageMatrix, partialModel = "all", numberOfBlock, hasBigHandle) {
    difference() {
        render() // preview display nothing without this
            union() {
                if (partialModel != "image_only") {
                    mug(mugHeight, mugRadius, mugThickness, hasBigHandle);
                }
                if (partialModel != "mug_only") {
                    rotate([0, 0, imageRotation]) {
                        imageMatrixOnCylinder(mugHeight, mugRadius, imageAngle, reliefMultiplier, imageMatrix);
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

module imageMatrixOnCylinder(height, radius, imageAngle, reliefMultiplier, imageMatrix) {
    /* constants. Do not change them */
    POINTS = 0;
    FACES = 1;

    polygonSurface = surfaceDataf(imageMatrix);

    //points = polygonSurface[POINTS];
    points = wrapAroundCylinder(polygonSurface[POINTS], [len(imageMatrix[0]), len(imageMatrix)], radius,
    height, imageAngle, reliefMultiplier);

    polyhedron(points = points, faces = polygonSurface[FACES]);
}
