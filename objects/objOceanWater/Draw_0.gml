draw_sprite_part_ext(sprite_index, image_index, 0, 0, sprite_width - tile_h, sprite_height - tile_v, x + tile_h, y + tile_v, image_xscale, image_yscale, image_blend, image_alpha);
draw_sprite_part_ext(sprite_index, image_index, sprite_width - tile_h, 0, tile_h, sprite_height - tile_v, x, y + tile_v, image_xscale, image_yscale, image_blend, image_alpha);
draw_sprite_part_ext(sprite_index, image_index, 0, sprite_height - tile_v, sprite_width - tile_h, tile_v, x + tile_h, y, image_xscale, image_yscale, image_blend, image_alpha);
draw_sprite_part_ext(sprite_index, image_index, sprite_width - tile_h, sprite_height - tile_v, tile_h, tile_v, x, y, image_xscale, image_yscale, image_blend, image_alpha);