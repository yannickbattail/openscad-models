include <coords.scad>

function wrapPointAroundCylinder(point, imageAngle, imageWidth, imageHeight, reliefMultipier)
= let(
    a = point[0] * imageAngle / imageWidth,
    r = point[2] * reliefMultipier + imageWidth,
    h = imageHeight - point[1],
    pol = polar_to_xy([r, a])
)
    [
    pol[0],
    pol[1],
    h
    ];

function wrapAroundCylinder(points, imageAngle, imageWidth, imageHeight, reliefMultipier = 1)
= [for (p = points) wrapPointAroundCylinder(p, imageAngle, imageWidth, imageHeight, reliefMultipier)];
