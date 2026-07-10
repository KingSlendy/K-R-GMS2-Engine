function draw_text_outline(x, y, text, border_color) {
	var color = draw_get_color();
	draw_set_color(border_color);

	for (var i = -1; i < 2; i++) {
	    for (var j = -1; j < 2; j++) {
	        draw_text(x + j, y + i, text);
	    }
	}

	draw_set_colour(color);
	draw_text(x, y, text);
}

function draw_rectangle_ext(x, y, w, h, rot, outline) {
    matrix_set(matrix_world, matrix_build(x, y, 0, 0, 0, rot, 1, 1, 1));
    draw_rectangle(-w / 2, -h / 2, w / 2, h / 2, outline);
    matrix_set(matrix_world, matrix_build_identity());
}

function draw_sprite_fog(sprite, subimg, x, y, xscale, yscale, rot, col, alpha, fog_color = c_black) {
	gpu_set_fog(true, fog_color, 0, 0);
	draw_sprite_ext(sprite, subimg, x, y, xscale, yscale, rot, col, alpha);
	gpu_set_fog(false, c_black, 0, 0);
}