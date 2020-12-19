if (speed != 0) {
	if (bounce) {
        if (check_object(hspeed, 0, objBlock)) {
            hspeed *= -1;
        }
        
        if (check_object(0, vspeed, objBlock))  {
            vspeed *= -1;
        }
    }
	
    with (instance_place(x, y - 2 * global.grav, objPlayer)) {
		if (platform_top(other) && !check_object(0, global.grav, objBlock)) {
			if (!check_object(other.hspeed, 0, objBlock)) {
				x += other.hspeed;
			}
			
			if (!check_object(0, other.vspeed, objBlock)) {
				y += other.vspeed;
				gravity = 0;
			}
		}
    }
}