var tangible = function(obj) { return (obj.image_alpha == 1); }

if (speed != 0 && image_alpha == 1) { //make sure the platform is moving before doing collision checks
	if (bounce) {
		move_bounce();
	}
	
	with (instance_place(x, y, objPlayer)) {
		y += other.vspeed;
	}
	with (instance_place(x, y + other.vspeed - (2 * global.grav), objPlayer)) {
	    if (instance_place_check(x + other.hspeed, y, objBlock, tangible) == noone) {
	        x += other.hspeed;
	    }
	}
}