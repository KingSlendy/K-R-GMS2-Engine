tick = approach(tick, 20, 1);
if (tick == 20) {
	image_alpha = approach(image_alpha, 0, 0.05);
	if (image_alpha == 0) {
		instance_destroy();
	}
}