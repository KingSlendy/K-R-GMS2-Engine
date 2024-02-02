if (instance_exists(objPlayer) && objPlayer.jump_total != 3) {
	objPlayer.jump_total = 3;
	audio_play_sound(sndGainTriple, 0, false);
}