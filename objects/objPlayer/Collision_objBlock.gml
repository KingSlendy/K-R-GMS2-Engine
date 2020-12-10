if (check_block(hspeed, 0)) {
	x = (hspeed > 0) ? floor(x) : ceil(x);
	
	while (!check_block(sign(hspeed), 0)) {
		x += sign(hspeed);
	}
	
	hspeed = 0;
}

if (check_block(0, vspeed)) {
	y = (vspeed > 0) ? floor(y) : y;
	
	while (!check_block(0, sign(vspeed))) {
		y += sign(vspeed);
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

/*if (place_meeting(x + hspeed, y + vspeed, objPlayerKiller)) {
	with (instance_place(x + hspeed, y + vspeed, objPlayerKiller)) {
		image_blend = c_red;
		alarm[0] = game_get_speed(gamespeed_fps) / 2;
	}
}