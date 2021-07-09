//Detects a killer object
if (place_meeting(x, y, objPlayerKiller)) {
	kill_player();
}

//Touches screen border
if (global.outside_kills && outside_room()) {
	kill_player();
}