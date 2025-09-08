include <coords.scad>

function wrapAroundCylinder(points, imageDimention, radius, height, imageAngle, reliefMultiplier = 1) =
  [
    for (p = points)
      wrapPointAroundCylinder(p, imageDimention[0], imageDimention[1], radius, height, imageAngle, reliefMultiplier)
  ];

function wrapPointAroundCylinder(point, imageWidth, imageHeight, radius, height, imageAngle, reliefMultiplier) =
  let (a = point[0] * imageAngle / imageWidth, r = radius + point[2] * reliefMultiplier, h = imageHeight - point[1], z = h * height / imageHeight, pol = polar_to_xy([r, a]))
    [pol[0], pol[1], z];
