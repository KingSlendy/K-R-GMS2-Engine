if (other.image_alpha == 1) {
	with (objPlayer) {
		x = other.x - other.hspeed;
		y = other.y - other.vspeed;
		p_vspd(0);
		
		xscale = other.xscale;
		reset_jumps();
	}
	instance_destroy();
}