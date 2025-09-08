/* [Animation] */
// rotating animation
animation_rotation = false;

$vpt = animation_rotation ? [0, 0, 0] : [];
$vpr = animation_rotation ? [70, 0, 365 * $t] : [];
$vpd = animation_rotation ? 100 : [];

cube();
