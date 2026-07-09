if (spin) {
	var cam = camera_properties(0);
	var diff = angle_difference(view_target, angle);
	var final_target = view_target;
	
	if (sign(diff) == 1 && angle > view_target) {
		final_target += 360;
	} else if (sign(diff) == -1 && angle < view_target) {
		final_target -= 360;
	}
	
	angle = approach(angle, final_target, 10);
	
	camera_set_view_angle(cam.view_cam, angle);
	
	if (angle == final_target) {
		angle = (angle + 360) % 360;
		flip_grav(grav);
		
		with (objRotateGravTemplate) {
			angle = other.angle;
		}
		
        spin = false;
		alarm[0] = seconds_to_frames(0.5);
	}
}