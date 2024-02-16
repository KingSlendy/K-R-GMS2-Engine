if (sign(image_xscale) == -1) {
	image_angle = (image_angle + 180) % 360;
	image_xscale *= -1;
}

var angle = floor((image_angle + 45) % 360 / 90) * 90;
angle %= 360;

tangible = 0;

if (abs(global.grav) == 1) {
	if (angle == 0) {
		tangible = 1;
	} else if (angle == 180) {
		tangible = -1;
	}
} else if (abs(global.grav) == 2) {
    if (angle == 270) {
		tangible = -1;
	} else if (angle == 90) {
		tangible = 1;
	}
} 