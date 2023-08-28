with (objPlayer) {
    x = other.x - other.hspeed;
    y = other.y - other.vspeed;
	p_vspd(0);
	
	xscale = other.xscale;
	reset_jumps();
}

event_inherited();