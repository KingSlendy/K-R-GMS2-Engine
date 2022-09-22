view_x = camera_properties(0).view_x;
view_y = camera_properties(0).view_y;
view_w = camera_properties(0).view_w;
view_h = camera_properties(0).view_h;

room_spd = room_speed;

function slowmo_view() {
	room_speed = room_spd * 0.4;
	
	if (instance_exists(objPlayer)) {
		var cam = camera_properties(0);
		var follow_x = objPlayer.x - cam.view_w / 4;
		var follow_y = objPlayer.y - cam.view_h / 4;
		
		follow_x = clamp(follow_x, 0, room_width - cam.view_w);
		follow_y = clamp(follow_y, 0, room_height - cam.view_h);
		
		var set_x = floor(follow_x / cam.view_w) * cam.view_w / 4;
		var set_y = floor(follow_y / cam.view_h) * cam.view_h / 4;
		camera_set_view_pos(cam.view_cam, set_x, set_y);
	}
}