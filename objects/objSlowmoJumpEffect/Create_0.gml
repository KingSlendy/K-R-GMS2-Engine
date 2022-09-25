view_x = camera_properties(0).view_x;
view_y = camera_properties(0).view_y;
view_w = camera_properties(0).view_w;
view_h = camera_properties(0).view_h;

room_spd = room_speed;

function slowmo_view() {
	room_speed = room_spd * 0.4;
	
	if (instance_exists(objPlayer)) {
		var cam = camera_properties(0);
	    var follow_x = objPlayer.x - view_w / 8;
	    var follow_y = objPlayer.y - view_h / 8;
    
	    follow_x = clamp(follow_x, 0, room_width - view_w / 4);
	    follow_y = clamp(follow_y, 0, room_height - view_h / 4);
		
		camera_set_view_pos(cam.view_cam, follow_x, follow_y);
		camera_set_view_size(cam.view_cam, view_w / 4, view_h / 4);
	}
}