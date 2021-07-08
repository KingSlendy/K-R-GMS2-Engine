x = xprevious;
y = yprevious;

//Detect horizontal collision
if (place_meeting(x + hspeed, y, objBlock)) {
	while (!place_meeting(x + sign(hspeed), y, objBlock)) {
		x += sign(hspeed);
	}
	
    hspeed = 0;
}

//Detect vertical collision
if (place_meeting(x, y + vspeed, objBlock)) {
	while (!place_meeting(x, y + sign(vspeed), objBlock)) {
		y += sign(vspeed);
	}
	
	if (vspeed * global.grav > 0) {
		reset_jumps();
	}
	
    vspeed = 0;
}

//Detect diagonal collision
if (place_meeting(x + hspeed, y + vspeed, objBlock)) {
	hspeed = 0;
}

x += hspeed;
y += vspeed;