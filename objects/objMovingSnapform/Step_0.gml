event_inherited();

if (image_alpha == 1) {
	var p = {
		top: (abs(global.grav) == 1) ? bbox_top : bbox_left,
		bottom: (abs(global.grav) == 1) ? bbox_bottom : bbox_right,
	};
	
	with (p_instance_place(0, 0, objPlayer)) {
		if (is_pressed(global.controls.jump)) {
			p_y((sign(global.grav) == 1) ? p.top - 9 : p.bottom + 10);
			p_vspd(0);
		}
	}
}