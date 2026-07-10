if (!opened) {
	draw_self();
} else {
	//left
	draw_sprite_part_ext(sprite_index, image_index, door_xoffset, door_yoffset, (sprite_width / 2) - door_xoffset, (sprite_height / 2) - door_yoffset, x, y, image_xscale, image_yscale, image_blend, image_alpha);
	draw_sprite_part_ext(sprite_index, image_index, door_xoffset, sprite_height / 2, (sprite_width / 2) - door_xoffset, (sprite_height / 2) - door_yoffset, x, y + (sprite_height / 2) + door_yoffset, image_xscale, image_yscale, image_blend, image_alpha);

	//right
	draw_sprite_part_ext(sprite_index, image_index, sprite_width / 2, door_yoffset, (sprite_width / 2) - door_xoffset, (sprite_height / 2) - door_yoffset, x + (sprite_width / 2) + door_xoffset, y, image_xscale, image_yscale, image_blend, image_alpha);
	draw_sprite_part_ext(sprite_index, image_index, sprite_width / 2, sprite_height / 2, (sprite_width / 2) - door_xoffset, (sprite_height / 2) - door_yoffset, x + (sprite_width / 2) + door_xoffset, y + (sprite_height / 2) + door_yoffset, image_xscale, image_yscale, image_blend, image_alpha);
}