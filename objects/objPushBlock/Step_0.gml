var tangible = function(obj) { return (obj.image_alpha == 1); }

hspeed = 0;
if (instance_exists(objPlayer)) {
	if (instance_place_check(x + push_spd * sign(objPlayer.hspd), y, objBlock, tangible) == noone) {
		if (place_meeting(x - 1, y, objPlayer) && is_held(global.controls.right)) {
			hspeed = push_spd;
		} else if (place_meeting(x + 1, y, objPlayer) && is_held(global.controls.left)) {
			hspeed = -push_spd;
		}
	}
	
	vspeed = (instance_place_check(x, y + sign(fall_spd), objBlock, tangible) != noone) ? 0 : fall_spd;
	if(vspeed != 0 && place_meeting(x, y + vspeed, objPlayer)) {
		kill_player();
	}
}