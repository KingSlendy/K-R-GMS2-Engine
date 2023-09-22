var status_color = [c_green, c_yellow, c_red];
draw_set_color(status_color[status]);
draw_roundrect((x + 28 * (sprite_width / 32)) - (sprite_width / 2), y - (sprite_height / 2), (x + sprite_width) - (sprite_width / 2), (y + 4 * (sprite_height / 32)) - (sprite_height / 2), false);
draw_set_color(c_white);