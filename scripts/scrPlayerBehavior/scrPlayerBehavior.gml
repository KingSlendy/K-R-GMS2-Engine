function check_object(plus_h, plus_v, object) {
	return place_meeting(x + plus_h, y + plus_v, object)
}

function platform_top(platform) {
	return (platform != noone && ((global.grav == 1) ? bbox_bottom <= platform.bbox_top : bbox_top >= platform.bbox_bottom));
}

function reset_jumps() {
	if (instance_exists(objPlayer)) {
		with (objPlayer) {
			jump_left = jump_total - 1;
		}
	}
}

function check_killer() {
	if (check_object(0, 0, objPlayerKiller) && !check_object(0, 0, objBlock)) {
		kill_player();
		return true;
	}
	
	return false;
}

function kill_player() {
    if (!global.debug_god_mode && instance_exists(objPlayer)) {
        with (objPlayer) {
			instance_create_layer(x, y, "Player", objBloodEmitter);
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