
tangible = false;
debug = false;

if (abs(global.grav) == 1) {
    if (abs(image_angle) != 90 && abs(image_angle) != 270) {
        tangible = true;
    }
} else if (abs(global.grav) == 2) {
    if (image_angle != 0 && abs(image_angle) mod 0 != 180) {
        tangible = true;
    }
}