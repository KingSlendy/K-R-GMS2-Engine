x += hspd;
y += vspd;

if (place_meeting(x, y, objPlayer)) {
	objPlayer.x += hspd;
	objPlayer.y += vspd;
}

hspd = (x - xprevious);
vspd = (y - yprevious);