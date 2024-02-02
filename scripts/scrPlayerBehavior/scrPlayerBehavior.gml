function player_jump() {
	if (global.forms.vkid == 0) {
		#region Jumping
		var platform = p_instance_place(0, sign(global.grav), objPlatform);
		
		if (jump_total > 0 && (on_block != null || (platform != null && platform.visible) || on_platform || p_instance_place(0, sign(global.grav), objWater1) != null || on_ladder)) {
			p_vspd(-(jump_height[0] * sign(global.grav)));
			on_ladder = false;
			player_sprite("Jump");
			reset_jumps();
			audio_play_sound(sndJump, 0, false);
		} else if (jump_left > 0 || p_instance_place(0, global.grav, objWater2) != null || jump_total == -1) {
			jump_velocity = 1;
			
			package_refrenture("player prejump");
			package_wetventure("player prejump");
				
			p_vspd((-(jump_height[1] * sign(global.grav)) * jump_velocity));
			package_refrenture("player postjump");
			player_sprite("Jump");
			
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
				} else if (global.forms.vkid == 2) {
					turn_grav();
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
	var bullet_object = (global.forms.telekid) ? objTelekid : objBullet;
	var shoot_sound = (global.forms.telekid) ? sndTelekid : sndShoot;
	
	if (global.forms.telekid) {
		bullet_max = 1;
	}

	if (instance_number(objBullet) < bullet_max) {
		instance_create_layer(x, y, "Player", bullet_object);
		audio_play_sound(shoot_sound, 0, false);
	}
}

function player_sprite(action = null) {
	if (global.forms.dotkid) {
		sprite_index = get_skin_sprite("Dotkid");
	} else if (global.forms.lunarkid) {
		sprite_index = get_skin_sprite("Lunarkid");
	} else if (global.forms.linekid) {
		sprite_index = get_skin_sprite("Linekid");
	} else {
		sprite_index = get_skin_sprite(action);
	}
}

function get_skin_sprite(action) {
	if (!variable_struct_exists(skins, skin)) {
		return sprite_index;
	}
	
	var sprites = skins[$ skin];
	
	if (!variable_struct_exists(sprites, action)) {
		return sprite_index;
	}
	
	return sprites[$ action];
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
		mask_index = sprPlayerMask;
	}
}

function flip_grav(grav = null, jump = true) {
	if (instance_exists(objPlayer)) {
		global.grav = (grav == null) ? global.grav * -1 : grav;

		if (!global.forms.lunarkid) {
		    with (objPlayer) {
				set_mask();
		        p_vspd(0);
		        p_y(Y + 4 * sign(global.grav));
		    }
		}

		if (jump) {
			reset_jumps();
		}
	}
}

function turn_grav(jump = true) {
	if (instance_exists(objPlayer)) {
		global.grav = (abs(global.grav) == 1) ? -(2 * objPlayer.xscale) : objPlayer.xscale;
	}
}