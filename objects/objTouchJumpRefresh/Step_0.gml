var player = instance_place_check(x, y, objPlayer, tangible_collision);

if (image_index == 0 && player) {
	with (objPlayer) {
		jump_left = approach(jump_left, jump_total - 1, 1);
	}
	image_index = 1;
	audio_play_sound(sndRefreshTouch, 0, false);
}