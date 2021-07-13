#region Movement
gravity = grav * global.grav;

if (on_platform) {
	gravity = 0;
}

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
		hspeed = max_hspeed * dir;
		image_speed = 0.5;
		sprite_index = PLAYER_ACTIONS.RUN;
	}
} else {
	hspeed = 0;
	image_speed = 0.2;
	sprite_index = PLAYER_ACTIONS.IDLE;
}

if (!on_platform) {
    if (vspeed * global.grav < -0.05) {
        sprite_index = PLAYER_ACTIONS.JUMP;
    } else if (vspeed * global.grav > 0.05) {
        sprite_index = PLAYER_ACTIONS.FALL;
    }
} else {
    if (!place_meeting(x, y + 4 * global.grav, objPlatform)) {
        on_platform = false;
    }
}

if (abs(vspeed) > max_vspeed) {
	vspeed = max_vspeed * sign(vspeed);
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
	    vspeed = 2 * global.grav;
		image_speed = 0.5;
	    sprite_index = PLAYER_ACTIONS.SLIDE;
    
	    if ((on_vineR && is_pressed(global.controls.right)) || (on_vineL && is_pressed(global.controls.left))) {
	        if (is_held(global.controls.jump)) {
	            hspeed = (on_vineR) ? 15 : -15;
	            vspeed = -9 * global.grav;
	            sprite_index = PLAYER_ACTIONS.JUMP;
				audio_play_sound(sndVine, 0, false);
	        } else {
	            hspeed = (on_vineR) ? 3 : -3;
	            sprite_index = PLAYER_ACTIONS.FALL;
	        }
	    }
	}
	
	if (global.debug_enable && on_block) {
		dir = (is_pressed(global.controls_debug.alignR) - is_pressed(global.controls_debug.alignL));
		
		if (dir != 0) {
			hspeed = dir;
		}
	}
}
#endregion

#region Collision
//Storing the previous x,y
xprevious = x;
yprevious = y;

//Moving the player before GM moves it automatically
vspeed += gravity;
x += hspeed;
y += vspeed;

//Collision with a block
if (place_meeting(x, y, objBlock)) {
	x = xprevious;
	y = yprevious;

	//Detect horizontal collision
	if (place_meeting(x + hspeed, y, objBlock)) {
		while (!place_meeting(x + sign(hspeed), y, objBlock)) {
			x += sign(hspeed);
		}
	
	    hspeed = 0;
	}

	//Detect vertical collision
	if (place_meeting(x, y + vspeed, objBlock)) {
		while (!place_meeting(x, y + sign(vspeed), objBlock)) {
			y += sign(vspeed);
		}
	
		if (vspeed * global.grav > 0) {
			reset_jumps();
		}
	
	    vspeed = 0;
		gravity = 0;
	}

	//Detect diagonal collision
	if (place_meeting(x + hspeed, y + vspeed, objBlock)) {
		hspeed = 0;
	}

	x += hspeed;
	y += vspeed;
}

//Stores the current speed and stops overriding GM from the automatic movement
hprevious = hspeed;
vprevious = vspeed;
gprevious = gravity;
hspeed = 0;
vspeed = 0;
gravity = 0;
#endregion