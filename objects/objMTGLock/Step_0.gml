if (collision_rectangle(bbox_left - 1, bbox_top - 1, bbox_right + 1, bbox_bottom + 3, objPlayer, 1, 1) && !opened) {
	if (is_pressed(ord("A")) && (collision_rectangle(bbox_left - 1, bbox_top + 1, bbox_right + 1, bbox_bottom + 3, objPlayer, 1, 1) || is_held(global.controls.down))) {
		opened = true;
	}
}