#region Collision with player
var player = instance_place(x, y, objPlayer);

if (player == noone && touching) {
	touching = false;
}

if (player != noone && !touching && image_alpha == 1) {
	touching = true;
	with (object_index) {
		if (id != other.id && image_blend == other.image_blend) {
			player.x = x + sprite_width / 2;
			player.y = y + sprite_height / 2;
			touching = true;
		}
	}
}
#endregion