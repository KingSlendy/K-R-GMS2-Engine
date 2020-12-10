#region Movement
var dir = (global.controls.right.is_held() - global.controls.left.is_held());

if (frozen) {
	dir = 0;
}

var onBlock = check_block(0, global.grav);
var onVineR = (place_meeting(x - 1, y, objVineR) && !onBlock);
var onVineL = (place_meeting(x + 1, y, objVineL) && !onBlock);
gravity = (!onBlock) ? 0.4 * global.grav : 0;

if (dir != 0) {
	if (!onVineR && !onVineL) {
		xscale = dir;
	}
	
	if ((dir == -1 && !onVineL) || (dir == 1 && !onVineR)) {
		hspeed = max_hspeed * dir;
		image_speed = 0.5;
		sprite_index = PLAYER_ACTIONS.RUN;
	}
} else {
	hspeed = 0;
	image_speed = 0.2;
	sprite_index = PLAYER_ACTIONS.IDLE;
}

if (vspeed * global.grav < 0) {
	sprite_index = PLAYER_ACTIONS.JUMP;
} else if (vspeed * global.grav > 0) {
	sprite_index = PLAYER_ACTIONS.FALL;
}

if (abs(vspeed) > max_vspeed) {
	vspeed = max_vspeed * sign(vspeed);
}

if (!frozen) {
	if (global.controls.jump.is_pressed()) {
		if (jump_total > 0 && onBlock) {
			vspeed = -(jump_height[0] * global.grav);
			sprite_index = PLAYER_ACTIONS.JUMP;
			reset_jumps();
			audio_play_sound(sndJump, 0, false);
		} else if (jump_left > 0 || place_meeting(x, y, objWater) || jump_total == -1) {
			vspeed = -(jump_height[1] * global.grav);
			sprite_index = PLAYER_ACTIONS.JUMP;
			
			if (!place_meeting(x, y, objWaterRefresh)) {
				if (jump_left > 0) {
					jump_left--;
				}
			} else {
				reset_jumps();
			}
			
			audio_play_sound(sndDoubleJump, 0, false);
		}
	}
	
	if (global.controls.jump.is_released()) {
		if (vspeed * global.grav < 0) {
			vspeed *= 0.45;
		}
	}
	
	if (global.controls.shoot.is_pressed()) {
		if (instance_number(objBullet) < 4) {
		    instance_create_layer(x, y, "Instances", objBullet);
			audio_play_sound(sndShoot, 0, false);
		}
	}
	
	if (onVineL || onVineR) {
		xscale = (onVineR) ? 1 : -1;
	    vspeed = 2 * global.grav;
	    sprite_index = PLAYER_ACTIONS.SLIDE;
	    image_speed = 1 / 2;
    
	    if ((onVineL && global.controls.left.is_pressed()) || (onVineR && global.controls.right.is_pressed())) {
	        if (global.controls.jump.is_held()) {
	            hspeed = (onVineR) ? 15 : -15;
	            vspeed = -9 * global.grav;
	            audio_play_sound(sndWalljump, 0, false);
	            sprite_index = PLAYER_ACTIONS.JUMP;
	        } else {
	            hspeed = (onVineR) ? 3 : -3;
	            sprite_index = PLAYER_ACTIONS.FALL;
	        }
	    }
	}
}
#endregion

#region Collisions
if (check_block(hspeed, 0)) {
	x = (hspeed > 0) ? floor(x) : ceil(x);
	
	while (!check_block(sign(hspeed), 0)) {
		x += sign(hspeed);
		
		if (check_killer()) {
			break;
		}
	}
	
	hspeed = 0;
}

if (check_block(0, vspeed)) {
	y = (vspeed > 0) ? floor(y) : ceil(y);
	
	while (!check_block(0, sign(vspeed))) {
		y += sign(vspeed);
		
		if (check_killer()) {
			break;
		}
	}
	
	if (vspeed * global.grav > 0) {
		reset_jumps();
	}
	
	vspeed = 0;
	gravity = 0;
}

if (check_block(hspeed, vspeed)) {
	hspeed = 0;
}

check_killer();
#endregion