if (other.trigger == trigger) {
	x = xprevious;
	y = yprevious;

	//Detect horizontal collision
	if (place_meeting(x + hspeed, y, other)) {
		while (!place_meeting(x + sign(hspeed), y, other)) {
			x += sign(hspeed);
		}
	
	    hspeed = 0;
	}

	//Detect vertical collision
	if (place_meeting(x, y + vspeed, other)) {
		while (!place_meeting(x, y + sign(vspeed), other)) {
			y += sign(vspeed);
		}

	    vspeed = 0;
	}

	//Detect diagonal collision
	if (place_meeting(x + hspeed, y + vspeed, other)) {
		hspeed = 0;
	}

	x += hspeed;
	y += vspeed;
}