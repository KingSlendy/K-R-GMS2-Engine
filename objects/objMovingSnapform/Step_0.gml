event_inherited();

if (image_alpha == 1) {
	with (instance_place(x, y, objPlayer)) {
		if (is_pressed(global.controls.jump)) {
			p_y((sign(global.grav) == 1) ? other.bbox_top - 9 : other.bbox_bottom + 9);
			p_vspd(0);
		}
	}
}