function player_jump() {
	var tangible = function(obj) { return (obj.image_alpha == 1); }
	
	if (global.forms.vkid == 0) {
		#region Jumping
		if (jump_total > 0 && (on_block != noone || instance_place_check(x, y + global.grav, objPlatform, tangible) != noone || instance_place_check(x, y + global.grav, objWater1, tangible) != noone || on_ladder)) {
			vspd = -(jump_height[0] * global.grav);
			on_ladder = false;
			player_sprite(PLAYER_ACTIONS.JUMP);
			reset_jumps();
			audio_play_sound(sndJump, 0, false);
		} else if (jump_left > 0 || instance_place_check(x, y + global.grav, objWater2, tangible) != noone || jump_total == -1) {
			vspd = -(jump_height[1] * global.grav);
			player_sprite(PLAYER_ACTIONS.JUMP);
			
			if (instance_place_check(x, y + global.grav, objWater3, tangible) == noone) {
				if (jump_left > 0) {
					jump_left--;
				}
			} else {
				reset_jumps();
			}
			
			audio_play_sound(sndDoubleJump, 0, false);
		}
		#endregion
	} else {
		#region Flipping
		if (!global.forms.lunarkid) {
			if (on_block != noone) {
				if (global.forms.vkid == 1) {
					flip_grav();
				}
				
				vspd = (jump_height[0] * global.grav);
				var sound = (global.grav == -1) ? sndVFlipDown : sndVFlipUp;
				audio_play_sound(sound, 0, false);
			}
		} else {
			gravity_direction += 180 / global.forms.vkid;
		}
		#endregion
	}
}

function player_fall() {
	if (vspd * global.grav < 0) {
		vspd *= 0.45;
	}
}

function player_shoot() {
	var bullet_max = 4;
	var bullet_object = objBullet;
	var shoot_sound = sndShoot;
	
	if (global.slowshot) {
		bullet_max = 10;
	} else if (global.forms.telekid) {
		bullet_max = 1;
		bullet_object = objPlayerTeleport;
		shoot_sound = sndTeleport;
	} 
	
	if (instance_number(objBullet) < bullet_max) {
		instance_create_layer(x, y, "Player", bullet_object);
		audio_play_sound(shoot_sound, 0, false);
	}
}

function player_sprite(sprite) {
	if (global.forms.dotkid) {
		sprite_index = PLAYER_ACTIONS.DOTKID;
	} else if (global.forms.lunarkid) {
		sprite_index = PLAYER_ACTIONS.LUNARKID;
	} else if (global.forms.linekid) {
		sprite_index = PLAYER_ACTIONS.LINEKID;
	} else {
		sprite_index = sprite;
	}
}

function reset_jumps() {
	with (objPlayer) {
		jump_left = jump_total - 1;
	}
}

function kill_player() {
	if (instance_exists(objPlayer)) {
	    if (!global.debug_god_mode) {
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
	    } else if (objPlayer.hit == 0) {
			with (objPlayer) {
				hit = global.debug_hit_time;
				hit_x = x;
				hit_y = y;
			}
			
			global.deaths++;
			audio_play_sound(sndDeath, 0, false);
		}
	}
}

function outside_room() {
	if (!instance_exists(objPlayer)) {
	    return false;
	}
	
	return (objPlayer.x < 0 || objPlayer.x > room_width || objPlayer.y < 0 || objPlayer.y > room_height);
}

function set_mask() {
	if (global.forms.dotkid || global.forms.lunarkid || global.forms.linekid) {
		mask_index = sprite_index;
	} else {
		mask_index = (global.grav == 1) ? sprPlayerMask : sprPlayerMaskFlipped;
	}
}

function flip_grav() {
	if (instance_exists(objPlayer)) {
	    global.grav *= -1;

	    with (objPlayer) {
			set_mask();
	        vspd = 0;
	        y += 4 * global.grav;
	    }
    
	    reset_jumps();
	}
}