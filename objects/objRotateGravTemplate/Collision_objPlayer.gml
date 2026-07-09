if (global.grav != grav && !spin) {
	with (objPlayer) {
        frozen = true;
    }
	
	audio_play_sound(sndBlockChange, 0, false);
	spin = true;
}