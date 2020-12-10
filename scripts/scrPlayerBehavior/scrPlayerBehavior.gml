function reset_jumps() {
	if (instance_exists(objPlayer)) {
		with (objPlayer) {
			jump_left = jump_total - 1;
		}
	}
}

function check_block(plus_h, plus_v) {
	return place_meeting(x + plus_h, y + plus_v, objBlock)
}

function check_platform(plus_h, plus_v) {
	return place_meeting(x + plus_h, y + plus_v, objPlatform);
}

function check_killer() {
	if (!place_meeting(x, y, objBlock) && place_meeting(x, y, objPlayerKiller)) {
		kill_player();
		return true;
	}
	
	return false;
}

function kill_player() {
	if (global.game_started) {
        if (instance_exists(objPlayer)) {
            with (objPlayer) {
				instance_create_layer(x, y, "Instances", objBloodEmitter);
                instance_destroy();
            }
            
			instance_create_layer(0, 0, "Instances", objGameOver);
            global.deaths++;
			audio_play_sound(sndDeath, 0, false);
			
			if (global.death_music) {
                audio_pause_sound(global.current_music);
                audio_play_sound(bgmGameOver, 0, false);
            }
        }
    } else {
        instance_destroy(objPlayer);
        room_restart();
    }
}

function outside_room() {
	if (!instance_exists(objPlayer)) {
	    return false;
	} else {
	    return (objPlayer.x < 0 || objPlayer.x > room_width || objPlayer.y < 0 || objPlayer.y > room_height);
	}
}

function set_mask() {
	mask_index = (global.grav == 1) ? sprPlayerMask : sprPlayerMaskFlipped;
}

function flip_grav() {
	if (instance_exists(objPlayer)) {
	    global.grav *= -1;

	    with (objPlayer) {
			set_mask();
	        vspeed = 0;
	        y += 4 * global.grav;
	        gravity *= -1;
	    }
    
	    reset_jumps();
	}
}