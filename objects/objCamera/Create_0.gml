leave_room = false;

function snap_view() {
	if (instance_exists(objPlayer)) {
		var cam = camera_properties(0);
	    var follow_x = objPlayer.x;
	    var follow_y = objPlayer.y;
    
	    if (!leave_room) {
	        follow_x = clamp(follow_x, 0, room_width - cam.view_w); 
	        follow_y = clamp(follow_y, 0, room_height - cam.view_h);   
	    }

	    var set_x = follow_x / cam.view_w * cam.view_w;
	    var set_y = follow_y / cam.view_h * cam.view_h;
		camera_set_view_pos(cam.view_cam, set_x, set_y);
	}
}