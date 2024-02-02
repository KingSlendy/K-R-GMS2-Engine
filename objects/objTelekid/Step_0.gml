if (!instance_exists(objPlayer)) {
	instance_destroy();
}

#region Collision with killers
var killer = instance_place_check(x, y, objCherry, tangible_collision);

if (killer != null && killer.visible) {
	kill_player();
}
#endregion