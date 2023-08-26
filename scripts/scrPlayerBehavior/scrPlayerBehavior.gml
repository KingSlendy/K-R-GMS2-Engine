function player_jump() {
	if (global.forms.vkid == 0) {
		#region Jumping
		var platform = p_instance_place(0, sign(global.grav), objPlatform);
		
		if (jump_total > 0 && (on_block != null || (platform != null && platform.visible) || on_platform || p_instance_place(0, global.grav, objWater1) != null || on_ladder)) {
			p_vspd(-(jump_height[0] * sign(global.grav)));
			on_ladder = false;
			player_sprite(PLAYER_ACTIONS.JUMP);
			reset_jumps();
			audio_play_sound(sndJump, 0, false);
		} else if (jump_left > 0 || p_instance_place(0, global.grav, objWater2) != null || jump_total == -1) {
			var jump_velocity = 1;
			
			package_refrenture("pre jump");
			
			#region Water Modifiers
			if (p_instance_place(0, 0, objFlipWater) != null) {
				flip_grav();
			}
			
			if (p_instance_place(0, 0, objPlatformWater) != null) {
				grav_amount = 0.4;
			}
			
			var bubble = p_instance_place(0, 0, objBubbleWater);
			
			if (bubble != null && sign(global.grav) == -sign(bubble.vspd)) {
				jump_velocity = 1.25;
			}
			#endregion
				
			p_vspd((-(jump_height[1] * sign(global.grav)) * jump_velocity));
			package_refrenture("post jump");
			player_sprite(PLAYER_ACTIONS.JUMP);
			
			if (p_instance_place(0, sign(global.grav), objWater3) == null) {
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
				
				p_vspd(jump_height[0] * sign(global.grav));
				var sound = (sign(global.grav) == -1) ? sndVFlipDown : sndVFlipUp;
				audio_play_sound(sound, 0, false);
			}
		} else {
			gravity_direction += 180 / global.forms.vkid;
		}
		#endregion
	}
}

function player_fall() {
	if (Vspd * sign(global.grav) < 0) {
		p_vspd(Vspd * 0.45);
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

function flip_grav(grav = undefined, jump = true) {
	if (instance_exists(objPlayer)) {
		if (grav == undefined) {
			global.grav *= -1;
		} else {
	    	global.grav = grav;
		}

	    with (objPlayer) {
			set_mask();
	        p_vspd(0);
	        p_y(Y + 4 * sign(global.grav));
	    }
    
		if (jump) {
			reset_jumps();
		}
	}
}