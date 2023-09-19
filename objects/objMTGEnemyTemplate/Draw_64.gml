var status_color = [c_green, c_yellow, c_red];
draw_set_color(status_color[status]);
draw_roundrect((x + 28 * (sprite_width / 32)) - 16, y - 16, (x + sprite_width) - 16, (y + 4 * (sprite_height / 32)) - 16, false);
draw_set_color(c_white);