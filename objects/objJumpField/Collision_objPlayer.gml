if (other.jump_total != 2 + image_index) {
	other.jump_total = 2 + image_index;
	var sound = (image_index == 0) ? sndLoseTriple : sndGainTriple;
	audio_play_sound(sound, 0, false);
}