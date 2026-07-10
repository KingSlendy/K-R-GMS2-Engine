if (image_alpha == 1) {
	instance_destroy(other);

	if (!moving) {
		if ((instance_place_check(x + 2 * sign(other.hspeed), y + 2 * sign(other.vspeed), objBlock, tangible_collision) == null) 
		|| instance_place_check(x, y, objPastelWaterGreen, tangible_collision) != null) {
			spd_set(2 * sign(other.speed), other.direction);
			moving = true;
		}
	}
}