var dir = 90 * abs(global.grav) - (90 * sign(global.grav));
var spd = (global.forms.telekid) ? 4 : 16;
var time = (global.slowshot) ? 800 : 40;

if (instance_exists(objPlayer) && global.forms.lunarkid) {
	dir = objPlayer.image_angle + 90;
}

if (global.slowshot) {
	spd = 1;
}

direction = dir;
speed = (global.forms.lunarkid) ? spd : spd * (objPlayer.xscale * sign(global.grav));

if (!global.forms.telekid) {
	alarm[0] = time;
}