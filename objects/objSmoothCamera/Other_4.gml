if (instance_exists(objPlayer)) {
	var cam = camera_properties(0);
	now_x = objPlayer.x - cam.view_w / 2;
	now_y = objPlayer.y - cam.view_h / 2;

	if (!leave_room) {
		now_x = clamp(now_x, 0, room_width - cam.view_w);
		now_y = clamp(now_y, 0, room_height - cam.view_h);
	}

	camera_set_view_pos(cam.view_cam, now_x, now_y);
}

view_enabled[0] = true;
view_set_visible(0, true);