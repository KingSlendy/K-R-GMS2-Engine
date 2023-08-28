///Asset package for "I wanna go the Ocean Wetventure"

function package_wetventure(load_type = undefined) {
	if (load_type == undefined) { exit; }

	switch(load_type) {
		case "vars": //load the Ocean Wetventure variables
		water_mod = {
			bubble: 0,
			platform: 0,
		};
		
		max_poison = 130;
		poison_time = max_poison;
		break;
		
		case "player prestep": //Handles collision with Weird Water and Poison Water
		frozen += (p_instance_place(0, 0, objWeirdWater) != null && Hspd != 0);
		
		if (collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, objPoisonWater, 0, 0) != noone) {
		    poison_time = approach(poison_time, 0, 1);
			
		    if (poison_time == 0) {
		        kill_player();
			}
		} else if (poison_time != max_poison) {
		    poison_time = max_poison;
		}
		break;

		case "player draw": //Draw a healthbar for the player when submerged in Poison Water
	    if (poison_time < max_poison) {
	        draw_healthbar(x - 16, y - 24, x + 16, y - 20, (poison_time / max_poison) * 100, c_black, c_red, c_white, 0, 1, 1);
		}
		break;
		
		case "player prejump": //Sets how jumping in gimmick waters will effect your jump
		if (p_instance_place(0, 0, objFlipWater) != null) {
			flip_grav();
		}
		
		if (p_instance_place(0, 0, objTurnWater) != null) {
			turn_grav();
		}
		
		if (p_instance_place(0, 0, objPlatformWater) != null) {
			grav_amount = 0.4;
		}
		
		var bubble = p_instance_place(0, 0, objBubbleWater);
		
		if (bubble != null && sign(global.grav) == -sign(bubble.spd)) {
			jump_velocity = 1.25;
		}
		break;
	}
}

function wetventure_gun_accelerate() {
	var accel_dir = (abs(global.grav) == 1) ? xscale : -xscale;
	if (is_pressed(global.controls.shoot)) {
		p_hspd(-(max_hspd * 2) * accel_dir);
	}
	
	p_hspd(approach(Hspd, 0, 0.1));
}