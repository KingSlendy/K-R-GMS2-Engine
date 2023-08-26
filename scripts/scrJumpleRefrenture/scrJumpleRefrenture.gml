///Asset package of "I wanna go the Jumple Refrenture"

function package_refrenture(load_type = undefined) {
	if (load_type == undefined) { exit; }
	
	switch(load_type) {
		case "vars": //load the Jumple Refrenture variables
		jump_mod = {
			high: 0,
			low: 0,
			flip: 0,
			tele: 0,
			fast: 0,
			swap: null,
			slowmo: 0,
			turn: 0,
		};
		break;
		
		case "player step": //Sets the kid's local speed based on the active jump modifier
		if (on_block != null || on_platform) {
			struct_set_all(jump_mod, 0);
			jump_mod.swap = null;
			
			if (instance_exists(objSlowmoJumpEffect)) {
				instance_destroy(objSlowmoJumpEffect);
			}
		}
		
		if (jump_mod.fast == 2) {
			max_hspd = 6;
		}
		
		if (jump_mod.high == 1) {
			jump_height[1] = 12;
		} else if (jump_mod.low == 1) {
			jump_height[1] = 5;
		} else {
			jump_height[1] = 7;
		}
		break;
		
		case "player draw": //Draws the telekid hitbox when the teleport modifier is active
		if (jump_mod.tele > 0) {
			var tele_x = (abs(global.grav) == 1) ? 96 * xscale : 0;
			var tele_y = (abs(global.grav) == 2) ? 96 * -xscale : 0;
			draw_sprite_ext(mask_index, image_index, x + tele_x, y + tele_y, image_xscale, image_yscale, image_angle, c_fuchsia, 0.5);
		}
		break;
		
		case "pre jump": //Sets the jump modifier flags for the next djump
		if (jump_mod.slowmo == 1) { //slowmo djump
			if (!instance_exists(objSlowmoJumpEffect)) {
				instance_create_layer(0, 0, layer, objSlowmoJumpEffect);
			}
			
			jump_mod.slowmo = 2;
		} else {
			instance_destroy(objSlowmoJumpEffect);
		}
		
		if (jump_mod.swap != null) { //switch djump
			if (!is_active_trigger(jump_mod.swap)) {
				activate_trigger(jump_mod.swap);
			} else {
				deactivate_trigger(jump_mod.swap);
			}
			jump_mod.swap = null;
			audio_play_sound(sndJumpSwap, 0, false);
		}
		
		if (jump_mod.fast == 1) { //fast djump
			jump_mod.fast = 2;
		}
		
		if (jump_mod.tele == 1) { //teleport djump
			var tele_dir = (abs(global.grav) == 1) ? xscale : -xscale;
			var tele_x = 96 * tele_dir;
			
			if (p_instance_place(tele_x, 0, objBlock) == null) {
				p_x(X + tele_x);
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
		
		if (jump_mod.turn == 1) { //turn djump
			turn_grav();
			jump_mod.turn = 2;
		}
		break;
		
		case "post jump": //Resets the jump modifier flags after djumping
		jump_mod.high = 2;
		jump_mod.low = 2;
		break;
	}
}