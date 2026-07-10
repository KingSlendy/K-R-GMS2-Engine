if (image_alpha == 1) {
	instance_destroy(other);
	
	water = instance_create_depth(x - 16, y - 16, depth - 1, objPastelWaterGreen);
	water.direction = image_angle;
	water.speed = spd;
	
	if (destroy) {
		instance_destroy();
	}
}