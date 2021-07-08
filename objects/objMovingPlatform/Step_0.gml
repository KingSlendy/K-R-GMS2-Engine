if (speed != 0 || yspeed != 0) {
    if (bounce) {
        if (place_meeting(x + hspeed, y, objBlock)) {
            hspeed = -hspeed;
        }
        
        if (place_meeting(x, y + vspeed + yspeed, objBlock))  {
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
        y += other.vspeed + other.yspeed;
        
        if (!place_meeting(x + other.hspeed, y, objBlock)) {
            x += other.hspeed;
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