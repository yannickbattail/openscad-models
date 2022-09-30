include <coords.scad>

function wrapPointAroundCylinder(point, diamter, imageAngle, imageWidth, imageHeight, reliefMultipier)
= let(
    a = point[0] * imageAngle / imageWidth,
    r = diamter + point[2] * reliefMultipier,
    h = imageHeight - point[1],
    pol = polar_to_xy([r, a])
)
    [
    pol[0],
    pol[1],
    h
    ];

function wrapAroundCylinder(points, diamter, imageAngle, imageWidth, imageHeight, reliefMultipier = 1)
= [for (p = points) wrapPointAroundCylinder(p, diamter, imageAngle, imageWidth, imageHeight, reliefMultipier)];
