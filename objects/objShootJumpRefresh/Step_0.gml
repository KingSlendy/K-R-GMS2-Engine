var bullet = instance_place_check(x, y, objBullet, tangible_collision);

if (image_index == 0 && bullet) {
	with (objPlayer) {
		jump_left = approach(jump_left, jump_total - 1, 1);
	}
	image_index = 1;
	audio_play_sound(sndWallShoot, 0, false);
}