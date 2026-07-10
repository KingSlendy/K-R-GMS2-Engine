if (!opened) {
	draw_self();
} else {
	draw_sprite_part_ext(sprite_index, image_index, 0, door_yoffset, sprite_width, sprite_height - door_yoffset, x, y + door_yoffset, image_xscale, image_yscale, image_blend, image_alpha);
}