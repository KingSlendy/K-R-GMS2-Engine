event_inherited();

if (bounce) {
    if (place_meeting(x + hspd, y, objBlock)) {
        hspd *= -1;
    }
        
    if (place_meeting(x, y + vspd, objBlock))  {
		vspd *= -1;
    }
}