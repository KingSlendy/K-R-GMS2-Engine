draw_set_font(fntMenu3);
draw_set_color(c_black);
draw_set_halign(fa_right);
draw_text_outline(760, 40, string("Orig: {0}", test_dist.orig), c_white);
draw_text_outline(760, 60, string("Xpos: {0}", test_dist.xpos), c_white);
draw_text_outline(760, 80, string("Xneg: {0}", test_dist.xneg), c_white);
draw_text_outline(760, 100, string("Ypos: {0}", test_dist.ypos), c_white);
draw_text_outline(760, 120, string("Yneg: {0}", test_dist.yneg), c_white);
draw_set_halign(fa_left);
draw_set_color(c_white);