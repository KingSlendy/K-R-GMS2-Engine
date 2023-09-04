if (speed != 0 && image_alpha == 1) { //make sure the platform is moving before doing collision checks
	if (bounce) {
		move_bounce();
	}

	hspd = (abs(global.grav) == 1) ? hspeed : vspeed;
	vspd = (abs(global.grav) == 1) ? vspeed : hspeed;

	if (abs(global.grav) == 1) {
		with (instance_place(x, y, objPlayer)) {
			y += other.vspeed;
		}
	}
	
	with (p_instance_place(0, vspd - 2 * sign(global.grav), objPlayer)) {
	    if (p_instance_place(other.hspd, 0, objBlock) == null) {
	    	p_x(X + other.hspd);
	    }
	}
	
	/*with (instance_place(x, y, objPlayer)) {
		y += other.vspeed;
	}
	with (instance_place(x, y + vspeed - 2 * sign(global.grav), objPlayer)) {
	    if (instance_place_check(x + other.hspeed, y, objBlock, tangible_collision) == null) {
	        x += other.hspeed;
	    }
	}*/
}