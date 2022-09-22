event_inherited();

if (image_alpha == 1) {
	with (instance_place(x, y, objPlayer)) {
		if (is_pressed(global.controls.jump)) {
			y = (global.grav == 1) ? other.y - 9 : other.y + other.sprite_height + 8;
			vspd = 0;
		}
	}
}