#region Collision with player
if (collision_rectangle(bbox_left - 1, bbox_top - 1, bbox_right + 1, bbox_bottom + 3, objPlayer, 1, 1)) {
	if (is_pressed(ord("X")) && (collision_rectangle(bbox_left - 1, bbox_top + 1, bbox_right + 1, bbox_bottom + 3, objPlayer, 1, 1) || is_held(global.controls.down))) {
		if (num > -1) {
			global.items_mtg[$ type][num] = true;
			opened = true;
		}
	}
}
#endregion

#region Door Opening
if (opened) {
	door_yoffset = approach(door_yoffset, sprite_height, image_yscale / open_time);
	if (door_yoffset == sprite_height) {
		instance_destroy();
	}
}
#endregion