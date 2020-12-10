var draw_y = y;

if (global.grav == -1) {
    draw_y++;
}

draw_sprite_ext(sprite_index, image_index, floor(x), floor(draw_y), image_xscale * xscale, image_yscale * global.grav, image_angle, image_blend, image_alpha);