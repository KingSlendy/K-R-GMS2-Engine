if (!opened) {
	draw_self();
} else {
	draw_sprite_part_ext(sprite_index, image_index, door_xoffset, 0, (sprite_width / 2) - door_xoffset, sprite_height, x, y, image_xscale, image_yscale, image_blend, image_alpha);
	draw_sprite_part_ext(sprite_index, image_index, sprite_width / 2, 0, (sprite_width / 2) - door_xoffset, sprite_height, x + (sprite_width / 2) + door_xoffset, y, image_xscale, image_yscale, image_blend, image_alpha);
}