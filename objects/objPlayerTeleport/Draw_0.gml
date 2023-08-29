var draw_x = x;
var draw_y = y;
if (global.grav == -2) {
	draw_x++;
}
if (global.grav == -1) {
	draw_y++;
}

draw_sprite_fog(sprite_index, image_index, draw_x, draw_y, xscale, yscale, angle, image_blend, 1, image_blend);