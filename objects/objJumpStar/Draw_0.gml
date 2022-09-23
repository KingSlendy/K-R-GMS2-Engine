draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, star_color, image_alpha);

if (jumps == 0) { 
	star_color = c_black; 
} else if (jumps > 0 && jumps < 4) { 
	star_color = c_white; 
} else if (jumps >= 4) { 
    star_color = make_color_hsv((jumps - 4) * 16, 255, 255);
	image_index = 2;
}

if (effect) {
    draw_sprite_ext(sprite_index, image_index, x, y, scale, scale, 0, star_color, alpha);
    scale += 0.05;
	
	alpha = approach(alpha, 0, 0.04);
    if (alpha == 0) { 
		effect = false; 
	}
}