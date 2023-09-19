if (global.grav != -1 && !spin) {
	other.frozen = true;
	audio_play_sound(sndBlockChange, 0, false);
	spin = true;
}