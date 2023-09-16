if (visible) {
	event_inherited();
	audio_play_sound(sndBooster, 0, false);
	reset_jumps();
	visible = false;
}