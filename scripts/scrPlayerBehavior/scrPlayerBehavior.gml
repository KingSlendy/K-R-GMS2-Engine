function player_jump() {
	if (jump_total > 0 && (on_block || place_meeting(x, y + global.grav, objPlatform) || on_platform)) {
		vspeed = -(jump_height[0] * global.grav);
		sprite_index = PLAYER_ACTIONS.JUMP;
		reset_jumps();
		audio_play_sound(sndJump, 0, false);
	} else if (jump_left > 0 || place_meeting(x, y + global.grav, objWater) || jump_total == -1) {
		vspeed = -(jump_height[1] * global.grav);
		sprite_index = PLAYER_ACTIONS.JUMP;
			
		if (!place_meeting(x, y + global.grav, objWaterRefresh)) {
			if (jump_left > 0) {
				jump_left--;
			}
		} else {
			reset_jumps();
		}
			
		audio_play_sound(sndDoubleJump, 0, false);
	}
}

function player_fall() {
	if (vspeed * global.grav < 0) {
		vspeed *= 0.45;
	}
}

function player_shoot() {
	if (instance_number(objBullet) < 4) {
		instance_create_layer(x, y, "Player", objBullet);
		audio_play_sound(sndShoot, 0, false);
	}
}

function reset_jumps() {
	if (instance_exists(objPlayer)) {
		with (objPlayer) {
			jump_left = jump_total - 1;
		}
	}
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
	    }
    
	    reset_jumps();
	}
}