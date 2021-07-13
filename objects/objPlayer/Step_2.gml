//Returns previous speed
hspeed = hprevious;
vspeed = vprevious;
gravity = gprevious;

//Touches screen border
if (global.outside_kills && outside_room()) {
	kill_player();
}