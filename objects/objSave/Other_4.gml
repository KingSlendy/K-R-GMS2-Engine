if (global.difficulty > difficulty) {
	instance_destroy();
	exit;
}

if (grav == -1) {
	image_angle = 180;
	x += 32;
	y += 32;
} else if (grav == 2) {
	image_angle = 90;
	y += 32;
} else if (grav == -2) {
	image_angle = 270;
	x += 32;
}