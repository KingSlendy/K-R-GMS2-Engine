#region Collision with killers
var killer = instance_place(x, y, objPlayerKiller);

if (killer != noone && killer.visible) {
	kill_player();
}
#endregion

#region Touches screen border
if (global.outside_kills && outside_room()) {
	kill_player();
}
#endregion