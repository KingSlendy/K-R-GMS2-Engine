var dir = 1;
if (instance_exists(objPlayer)) {
	dir = (global.forms.lunarkid) ? objPlayer.image_angle + 90 : objPlayer.xscale;
}

var spd = (global.forms.telekid) ? 4 : 16;
var time = (global.slowshot) ? 800 : 40;

if (global.slowshot) {
	spd = 1;
}

if (global.forms.lunarkid) {
	direction = dir;
	speed = spd;
} else {
	hspeed = spd * dir;
}

if (!global.forms.telekid) {
	alarm[0] = time;
}