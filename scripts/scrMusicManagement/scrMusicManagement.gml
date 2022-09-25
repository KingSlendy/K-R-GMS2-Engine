function play_music(music, loop) {
	if (!audio_is_playing(music)) {
	    audio_stop_sound(global.current_music);
		global.current_music = (!global.display.mute_music && music != -1) ? audio_play_sound(music, 0, loop) : music;
	}
}

function stop_music() {
	if (global.current_music != -1) {
	    audio_stop_sound(global.current_music);
	    global.current_music = -1;
	}
}

function get_music() {
	var music;
	var loop = true;

	switch (room) {
	    case rTitle:
	    case rFiles:
	    case rOptions:
	        music = bgmGuyRock;
	        break;
        
	    default: music = (!instance_exists(objPlayMusic)) ? -1 : -2; break;
	}

	if (music != -2) {
	    play_music(music, loop);
	}
}

function toggle_music() {
	if (!global.display.mute_music) {
		if (instance_exists(objPlayer) || !global.game_started) {
			if (!instance_exists(objPlayMusic)) { //make sure the play music object isn't in the current room
			    get_music();  //find and play the proper music for the current room
			} else {   //objPlayMusic is in the room, use it to play music instead
			    with (objPlayMusic) {
					if (music != -2) {
						play_music(music, true);
					}
			    }
			}
		}
	} else { //mute music
		stop_music();
		audio_stop_sound(bgmGameOver);
	}
}