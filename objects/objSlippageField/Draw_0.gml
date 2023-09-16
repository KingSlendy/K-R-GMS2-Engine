if (slippage != 0) {
	color = (slippage > 0) ? make_color_hsv(224 * slippage, 255, 255) : make_color_hsv(255, 224 * slippage, 224 * slippage);
}

draw_sprite_ext(sprite_index, -1, x, y, image_xscale, image_yscale, image_angle, color, image_alpha);