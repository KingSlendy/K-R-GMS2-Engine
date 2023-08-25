if (speed != 0 && image_alpha == 1) { //make sure the platform is moving before doing collision checks
	if (bounce) {
		move_bounce();
	}
	
	with (instance_place(x, y, objPlayer)) {
		p_y(other.vspeed);
	}
	
	with (instance_place(X, Y + other.vspeed - (2 * sign(global.grav)), objPlayer)) {
	    if (p_instance_place(other.hspeed, 0, objBlock) == null) {
	        p_x(other.hspeed);
	    }
	}
}