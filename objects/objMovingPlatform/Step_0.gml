if (image_alpha == 1) { //make sure the platform is tangible before doing collision checks
	if (bounce) {
		move_bounce();
	}

	hspd = (abs(global.grav) == 1) ? hspeed : vspeed;
	vspd = (abs(global.grav) == 1) ? vspeed : hspeed;
	ypos = (abs(global.grav) == 1) ? y - yprevious : x - xprevious;
		
	#region Detect vertical collision
	with (p_instance_place(0, 0, objPlayer)) {
		if (p_instance_place(0, other.ypos, objBlock) == null) {
			p_y((other.vspd != 0) ? Y + other.vspd : Y + other.ypos);
		}
	}
	#endregion
	
	#region Detect horizontal collision
	with (p_instance_place(0, vspd - 2 * sign(global.grav), objPlayer)) {
	    if (p_instance_place(other.hspd, 0, objBlock) == null) {
	    	p_x(X + other.hspd);
	    }
	}
	#endregion
}
