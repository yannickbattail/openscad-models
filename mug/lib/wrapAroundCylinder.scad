include <coords.scad>

function wrapAroundCylinderPoint(point, imageAngle, image_width, reliefMultipier)
= let(
    a = point[0] * imageAngle / image_width,
    r = point[2] * reliefMultipier + image_width,
    h = point[1],
    pol = polar_to_xy([r, a])
)
    [
    pol[0],
    pol[1],
    h
    ];

function wrapAroundCylinder(points, imageAngle, image_width, reliefMultipier = 1)
= [for (p = points) wrapAroundCylinderPoint(p, imageAngle, image_width, reliefMultipier)];
