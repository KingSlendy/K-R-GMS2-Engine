function camera_properties(num) {
	var cam = view_camera[num];
	
	return {
		view_cam: cam,
		view_x: camera_get_view_x(cam),
		view_y: camera_get_view_y(cam),
		view_w: camera_get_view_width(cam),
		view_h: camera_get_view_height(cam),
		view_xw: camera_get_view_x(cam) + camera_get_view_width(cam),
		view_yh: camera_get_view_y(cam) + camera_get_view_height(cam),
		view_angle: camera_get_view_angle(cam),
	};
}

function camera_zoom(camera_id, x, y, w, angle) {
	camera_set_view_pos(camera_id, x - w / 2, y - w * 608 / 800 / 2);
	camera_set_view_size(camera_id, w, w * 608 / 800);
	camera_set_view_angle(camera_id, angle);
}

function camera_reset(camera_id) {
	camera_set_view_pos(camera_id, 0, 0);
	camera_set_view_size(camera_id, 800, 608);
	camera_set_view_angle(camera_id, 0);
}

function camera_set_view_x(camera_id, x) {
    camera_set_view_pos(camera_id, x, camera_get_view_y(camera_id));
}

function camera_set_view_y(camera_id, y) {
    camera_set_view_pos(camera_id, camera_get_view_x(camera_id), y);
}
