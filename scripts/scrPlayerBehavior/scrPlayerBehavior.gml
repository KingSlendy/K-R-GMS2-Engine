function player_jump() {
	if (global.forms.vkid == 0) {
		#region Jumping
		var platform = instance_place_check(x, y + global.grav, objPlatform, tangible_collision);
		
		if (jump_total > 0 && (on_block != null || (platform != null && platform.visible) || on_platform || instance_place_check(x, y + global.grav, objWater1, tangible_collision) != null || on_ladder)) {
			vspd = -(jump_height[0] * global.grav);
			on_ladder = false;
			player_sprite(PLAYER_ACTIONS.JUMP);
			reset_jumps();
			audio_play_sound(sndJump, 0, false);
		} else if (jump_left > 0 || instance_place_check(x, y + global.grav, objWater2, tangible_collision) != null || jump_total == -1) {
			var jump_velocity = 1;
			
			#region Refresher Modifiers	
			if (jump_mod.slowmo == 1) { //slowmo djump
				if (!instance_exists(objSlowmoJumpEffect)) {
					instance_create_layer(0, 0, layer, objSlowmoJumpEffect);
				}
				
				jump_mod.slowmo = 2;
			} else {
				instance_destroy(objSlowmoJumpEffect);
			}
			
			if (jump_mod.swap == 1) { //switch djump
				jump_mod.swap = 0;
				audio_play_sound(sndJumpSwap, 0, false);
			}
			
			if (jump_mod.fast == 1) { //fast djump
				jump_mod.fast = 2;
			}
			
			if (jump_mod.tele == 1) { //teleport djump
				var tele_x = 96 * xscale;
				
				if (instance_place_check(x + tele_x, y, objBlock, tangible_collision) == null) {
					x += tele_x;
					audio_play_sound(sndJumpTele, 0, false);
				}
				
				xprevious = x;
				yprevious = y;
				jump_mod.tele = 0;
			}
			
			if (jump_mod.flip == 1) { //flip djump
				flip_grav();
				jump_mod.flip = 2;
			}
			#endregion
			
			#region Water Modifiers
			if (instance_place_check(x, y, objFlipWater, tangible_collision) != null) {
				flip_grav();
			}
			
			if (instance_place_check(x, y, objPlatformWater, tangible_collision) != null) {
				grav_amount = 0.4;
			}
			
			var bubble = instance_place_check(x, y, objBubbleWater, tangible_collision);
			
			if (bubble != null && global.grav == -sign(bubble.vspd)) {
				jump_velocity = 1.25;
			}
			#endregion
				
			vspd = -((jump_height[1] * global.grav) * jump_velocity);
			jump_mod.high = 2;
			jump_mod.low = 2;
			player_sprite(PLAYER_ACTIONS.JUMP);
			
			if (instance_place_check(x, y + global.grav, objWater3, tangible_collision) == null) {
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
			if (on_block != null) {
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
	var bullet_max = (global.slowshot) ? 10 : 4;
	var bullet_object = (global.forms.telekid) ? objPlayerTeleport : objBullet;
	var shoot_sound = (global.forms.telekid) ? sndTeleport : sndShoot;
	
	if (global.forms.telekid) {
		bullet_max = 1;
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
	            audio_play_sound(bgmGameOver, 0, false, 0.5);
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
		if (abs(global.grav) == 1) {
			mask_index = (global.grav == 1) ? sprPlayerMask : sprPlayerMaskFlipped;
		} else if (abs(global.grav) == 2) {
			mask_index = (global.grav == 2) ? sprPlayerMaskX : sprPlayerMaskXFlipped;
		}
	}
}

function flip_grav(grav, jump = true) {
	if (instance_exists(objPlayer)) {
	    global.grav = grav;

	    with (objPlayer) {
			set_mask();
	        vspd = 0;
	        y += 4 * global.grav;
	    }
    
		if (jump) {
			reset_jumps();
		}
	}
}