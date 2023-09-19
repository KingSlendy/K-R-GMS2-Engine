draw_set_font(amount_font);
draw_set_alpha(image_alpha);
draw_text_transformed(x, y, string("+{0}", amount), 0.8, 0.8, 0);
draw_set_alpha(1);