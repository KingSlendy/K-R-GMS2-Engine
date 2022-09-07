#region Movement
grav = grav_amount * global.grav;

var dir_left = is_held(global.controls.left);
var dir_right = is_held(global.controls.right);
var dir = 0;

//If the player is frozen no movement is applied
if (!frozen) {
    if (dir_right) {
        dir = 1;
	} else if (dir_left) {
        dir = -1;
	}
}

on_block = place_meeting(x, y + global.grav, objBlock);
var on_vineR = (place_meeting(x - 1, y, objVineR) && !on_block);
var on_vineL = (place_meeting(x + 1, y, objVineL) && !on_block);

if (dir != 0) {
	if (!on_vineR && !on_vineL) {
		xscale = dir;
	}
	
	if ((dir == 1 && !on_vineR) || (dir == -1 && !on_vineL)) {
		hspd = max_hspd * dir;
		image_speed = 0.5;
		sprite_index = PLAYER_ACTIONS.RUN;
	}
} else {
	hspd = 0;
	image_speed = 0.2;
	sprite_index = PLAYER_ACTIONS.IDLE;
}

if (vspd * global.grav < -0.05) {
    sprite_index = PLAYER_ACTIONS.JUMP;
} else if (vspd * global.grav > 0.05) {
    sprite_index = PLAYER_ACTIONS.FALL;
}

if (abs(vspd) > max_vspd) {
	vspd = max_vspd * sign(vspd);
}

if (!frozen) {
	if (is_pressed(global.controls.jump)) {
		player_jump();
	}
	
	if (is_released(global.controls.jump)) {
		player_fall();
	}
	
	if (is_pressed(global.controls.shoot)) {
		player_shoot();
	}
	
	if (on_vineR || on_vineL) {
		xscale = (on_vineR) ? 1 : -1;
	    vspd = 2 * global.grav;
		image_speed = 0.5;
	    sprite_index = PLAYER_ACTIONS.SLIDE;
    
	    if ((on_vineR && is_pressed(global.controls.right)) || (on_vineL && is_pressed(global.controls.left))) {
	        if (is_held(global.controls.jump)) {
	            hspd = (on_vineR) ? 15 : -15;
	            vspd = -9 * global.grav;
	            sprite_index = PLAYER_ACTIONS.JUMP;
				audio_play_sound(sndVine, 0, false);
	        } else {
	            hspd = (on_vineR) ? 3 : -3;
	            sprite_index = PLAYER_ACTIONS.FALL;
	        }
	    }
	}
	
	if (global.debug_enable && on_block) {
		dir = (is_pressed(global.controls_debug.alignR) - is_pressed(global.controls_debug.alignL));
		
		if (dir != 0) {
			hspd = dir;
		}
	}
}
#endregion

#region Collision
//Storing the previous x and y
xprevious = x;
yprevious = y;

//Moving the player manually
vspd += grav;
x += hspd;
y += vspd;

//Collision with block
var block = instance_place(x, y, objBlock);

if (block != noone) {
	x = xprevious;
	y = yprevious;

	//Detect horizontal collision
	if (place_meeting(x + hspd, y, objBlock)) {
		while (!place_meeting(x + sign(hspd), y, objBlock)) {
			x += sign(hspd);
		}
	
	    hspd = 0;
	}

	//Detect vertical collision
	if (place_meeting(x, y + vspd, objBlock)) {
		while (!place_meeting(x, y + sign(vspd), objBlock)) {
			y += sign(vspd);
		}
	
		if (vspd * global.grav > 0) {
			reset_jumps();
		}
	
	    vspd = 0;
		grav = 0;
	}

	//Detect diagonal collision
	if (place_meeting(x + hspd, y + vspd, objBlock)) {
		hspd = 0;
	}

	x += hspd;
	y += vspd;
	
	//Makes player move based on the block speed
	if (!place_meeting(x + block.hspd, y, objBlock)) {
		x += block.hspd;
	}
	
	if (!place_meeting(x, y + block.vspd, objBlock)) {
		y += block.vspd;
	}
}

//Collision with platform
if (vspd * global.grav >= 0) {
	var platform = instance_place(x, y, objPlatform);
	
	if (platform != noone) {
		if (global.grav == 1) {
			var bbox_check = (bbox_bottom - max(1, abs(vspd)) <= platform.bbox_top + 1);
		} else {
			var bbox_check = (bbox_top + max(1, abs(vspd)) >= platform.bbox_bottom - 1);
		}

		if (bbox_check) {
			y = yprevious;
			
			//Detect vertical collision
			if (place_meeting(x, y + vspd, objPlatform)) {
				while (!place_meeting(x, y + sign(vspd), objPlatform)) {
					y += sign(vspd);
				}

				vspd = 0;
				grav = 0;
				reset_jumps();
			}
	
			y += vspd;
		
			//Makes player move based on the platform speed
			if (!place_meeting(x + platform.hspd, y, objBlock)) {
				x += platform.hspd;
			}
	
			if (!place_meeting(x, y + platform.vspd, objBlock)) {
				y += platform.vspd;
			}
		}
	}
}
#endregion