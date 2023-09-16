var direction_collision = function(obj) { return (obj.direction == image_angle % 180); }
var bullet = instance_place_check(x, y, objBullet, direction_collision);

if (image_index == 0 && bullet) {
	with (objPlayer) {
		jump_left = approach(jump_left, jump_total - 1, 1);
	}
	image_index = 1;
	audio_play_sound(sndRefreshShoot, 0, false);
}