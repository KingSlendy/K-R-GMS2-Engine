if (global.grav != 2 && !spin) {
	other.frozen = true;
	audio_play_sound(sndBlockChange, 0, false);
	spin = true;
}