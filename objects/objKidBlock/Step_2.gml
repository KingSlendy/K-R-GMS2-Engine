#region Collision with player
if (image_alpha == 1) {
	var player = instance_place(x, y, objPlayer);

	if (player != noone && (global.grav != grav)) {
		kill_player();
	}
}
#endregion