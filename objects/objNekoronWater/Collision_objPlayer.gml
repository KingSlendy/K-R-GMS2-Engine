with (objPlayer) {
	if (is_pressed(global.controls.jump) && jump_left == 0) {
		vspd = -(jump_height[1] * global.grav);
		audio_play_sound(sndDoubleJump, 0, false);
	}
	
	if (vspd * global.grav > 2) {
		vspd = 2 * global.grav;
	}
}