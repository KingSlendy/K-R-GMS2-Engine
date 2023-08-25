with (objPlayer) {
	if (is_pressed(global.controls.jump) && jump_left == 0) {
		p_vspd(-(jump_height[1] * sign(global.grav)));
		audio_play_sound(sndDoubleJump, 0, false);
	}
	
	if (Vspd * sign(global.grav) > 2) {
		p_vspd(2 * sign(global.grav));
	}
}