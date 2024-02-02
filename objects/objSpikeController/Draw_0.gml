if (sprite_exists(sprite_index)) {
	draw_func();
}

if (global.debug_enable) {
	if (keyboard_check(vk_control) && sprite_exists(mask_index)) {
		draw_sprite_ext(mask_index, -1, x, y, image_xscale, image_yscale, image_angle, c_fuchsia, 0.8);
	}
}