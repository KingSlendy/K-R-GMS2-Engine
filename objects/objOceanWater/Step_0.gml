tile_h += scroll_speed_h;
tile_v += scroll_speed_v;

if (scroll_speed_h > 0) {
    if (tile_h > sprite_width) {
        tile_h = 0;
	}
} else if (tile_h < 0) {
    tile_h = sprite_width;
}

if (scroll_speed_v > 0) {
    if (tile_v > sprite_height) {
        tile_v = 0;
	}
} else if (tile_v < 0) {
    tile_v = sprite_height;
}