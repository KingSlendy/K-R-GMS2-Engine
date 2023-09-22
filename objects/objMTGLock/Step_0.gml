#region Collision with player
if (collision_rectangle(bbox_left - 1, bbox_top - 1, bbox_right + 1, bbox_bottom + 3, objPlayer, 1, 1)) {
	if (is_pressed(ord("X")) && (collision_rectangle(bbox_left - 1, bbox_top + 1, bbox_right + 1, bbox_bottom + 3, objPlayer, 1, 1) || is_held(global.controls.down))) {
		if (num > -1 && global.keys_mtg[$ image_blend] > 0) {
			global.keys_mtg[$ image_blend] -= amount;
			global.items_mtg[$ type][num] = true;
			opened = true;
			
			with (objMTGStatusOverlay) {
				overlay_init();
			}
		}
	}
}
#endregion

#region Door Opening
if (opened) {
	door_xoffset = approach(door_xoffset, sprite_width / 2, image_xscale / open_time);
	if (door_xoffset == sprite_width / 2) {
		instance_destroy();
	}
}
#endregion