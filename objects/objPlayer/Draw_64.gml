draw_set_font(fntMenu3);
draw_set_color(c_black);
draw_set_halign(fa_right);
for (var i = 0; i < 5; i++) {
	draw_text_outline(760, 40 + 20 * i, string("test_dist[{0}]: {1}", i, test_dist[i]), c_white);
}
draw_set_halign(fa_left);
draw_set_color(c_white);