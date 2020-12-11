if (speed != 0 || yspeed != 0) {
    if (bounce) {
        if (check_block(hspeed, 0)) {
            hspeed = -hspeed;
        }
        
        if (check_block(0, vspeed + yspeed))  {
            if (vspeed != 0) {
                yspeed = -vspeed;
                vspeed = 0;
            } else  {
                vspeed = -yspeed;
                yspeed = 0;
            }
        }
    }
    
    with (instance_place(x, y - 2 * global.grav, objPlayer)) {
		if (!check_block(0, global.grav)) {
	        y += other.vspeed + other.yspeed;
        
	        if (!on_block) {
	            x += other.hspeed;
	        }
		}
    }
    
    y += yspeed;
    
    if (vspeed < 0) {
        yspeed = vspeed;
        vspeed = 0;
    }
    
    if (yspeed > 0) {
        vspeed = yspeed;
        yspeed = 0;
    }
}