if (global.slippage != slippage) {
	global.slippage = slippage;
	audio_play_sound(sndBlockChange, 0, false);
}