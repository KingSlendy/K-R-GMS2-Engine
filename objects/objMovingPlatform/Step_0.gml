if (speed != 0 && image_alpha == 1) { //make sure the platform is moving before doing collision checks
	if (bounce) {
		move_bounce();
	}

	hspd = (abs(global.grav) == 1) ? hspeed : vspeed;
	vspd = (abs(global.grav) == 1) ? vspeed : hspeed;
	
	with (p_instance_place(0, 0, objPlayer)) {
		if (p_instance_place(0, other.vspd, objBlock) == null) {
			p_y(Y + other.vspd);
		}
	}
	
	with (p_instance_place(0, vspd - 2 * sign(global.grav), objPlayer)) {
	    if (p_instance_place(other.hspd, 0, objBlock) == null) {
	    	p_x(X + other.hspd);
	    }
	}
}