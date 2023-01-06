hspd = 0;

if (instance_exists(objPlayer)) {
	if (instance_place_check(x + push_spd * sign(objPlayer.hspd), y, objBlock, tangible_collision) == null) {
		if (place_meeting(x - 1, y, objPlayer) && is_held(global.controls.right)) {
			hspd = push_spd;
		} else if (place_meeting(x + 1, y, objPlayer) && is_held(global.controls.left)) {
			hspd = -push_spd;
		}
	}
	
	vspd = (instance_place_check(x, y + sign(fall_spd), objBlock, tangible_collision) != null) ? 0 : fall_spd;
	
	if (vspd != 0 && place_meeting(x, y + vspd, objPlayer)) {
		kill_player();
	}
}

xprevious = x;
yprevious = y;

x += hspd;
y += vspd;

var block = instance_place_check(x, y, objBlock, tangible_collision);

if (block != null) {
	x = xprevious;
	y = yprevious;
	
	//Detect horizontal collision
	if (instance_place_check(x + hspd, y, objBlock, tangible_collision) != null) {
		while (instance_place_check(x + sign(hspd), y, objBlock, tangible_collision) == null) {
			x += sign(hspd);
		}
	
		hspd = 0;
	}

	//Detect vertical collision
	if (instance_place_check(x, y + vspd, objBlock, tangible_collision) != null) {
		while (instance_place_check(x, y + sign(vspd), objBlock, tangible_collision) == null) {
			y += sign(vspd);
		}
	
		vspd = 0;
	}

	//Detect diagonal collision
	if (instance_place_check(x + hspd, y + vspd, objBlock, tangible_collision) != null) {
		hspd = 0;
	}

	x += hspd;
	y += vspd;
}