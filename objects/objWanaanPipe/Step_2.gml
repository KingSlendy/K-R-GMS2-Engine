if (image_alpha == 1) {
	if (instance_place(x, y - lengthdir_y(2, image_angle - 90), objPlayer) != noone && trap == null) {
	    trap = instance_create_depth(x, y, depth, objWanaan);
	    trap.core = id;
		trap.image_angle = image_angle;
	    audio_play_sound(sndWanaan, 0, false);
	}
}