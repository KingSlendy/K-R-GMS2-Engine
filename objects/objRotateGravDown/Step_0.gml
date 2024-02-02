if (spin) {
	camera_set_view_angle(camera_properties(0).view_cam, angle);
    if (angle != view_target) {
        with (objPlayer) { 
			image_angle = other.angle; 
		}
		angle = approach(angle, view_target, 5);
    } else {
		flip_grav(1);
		with(objPlayer) {
            frozen = false;
            image_angle = 0;
        }
        spin = false; 
    }
}