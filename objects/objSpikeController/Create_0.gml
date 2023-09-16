event_inherited();
var draw_funcs = {};

#region Standard Spikes
draw_funcs[$ objSpikeRight] = function () {
	draw_self();
}
draw_funcs[$ objSpikeUp] = function () {
	draw_self();
}
draw_funcs[$ objSpikeLeft] = function () {
	draw_self();
}
draw_funcs[$ objSpikeDown] = function () {
	draw_self();
}
#endregion

#region Mini Spikes
draw_funcs[$ objMiniSpikeRight] = function () {
	if (sprite_get_width(sprite_index) > 16 || sprite_get_height(sprite_index) > 16) {
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale / 2, image_yscale / 2, image_angle, image_blend, image_alpha);
	} else {
		draw_self();
	}
}
draw_funcs[$ objMiniSpikeUp] = function () {
	if (sprite_get_width(sprite_index) > 16 || sprite_get_height(sprite_index) > 16) {
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale / 2, image_yscale / 2, image_angle, image_blend, image_alpha);
	} else {
		draw_self();
	}
}
draw_funcs[$ objMiniSpikeLeft] = function () {
	if (sprite_get_width(sprite_index) > 16 || sprite_get_height(sprite_index) > 16) {
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale / 2, image_yscale / 2, image_angle, image_blend, image_alpha);
	} else {
		draw_self();
	}
}
draw_funcs[$ objMiniSpikeDown] = function () {
	if (sprite_get_width(sprite_index) > 16 || sprite_get_height(sprite_index) > 16) {
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale / 2, image_yscale / 2, image_angle, image_blend, image_alpha);
	} else {
		draw_self();
	}
}
#endregion

#region Combo Spikes
xoff_combo = 0;
yoff_combo = 0;

xoff_block = 16 * image_xscale;
yoff_block = 16 * image_yscale;

xcen = 32 * image_xscale;
ycen = 32 * image_yscale;

start_angle = image_angle;

draw_funcs[$ objSpikeDiamondVertical] = function () {
	if (image_angle != start_angle) {
	    draw_sprite_ext(sprite_index, image_index, x + pivot_pos_x(-xoff_combo, -xoff_combo - (xcen / 2), image_angle), y + pivot_pos_y(-yoff_combo, -yoff_combo - (ycen / 2), image_angle), image_xscale, image_yscale, 90 + image_angle, image_blend, image_alpha);
	    draw_sprite_ext(sprite_index, image_index, x + pivot_pos_x(-xoff_combo, -xoff_combo + (xcen / 2), image_angle), y + pivot_pos_y(-yoff_combo, -yoff_combo + (ycen / 2), image_angle), image_xscale, image_yscale, 270 + image_angle, image_blend, image_alpha);
	} else {
		draw_sprite_ext(sprite_index, image_index, x, y - 16 * image_yscale, image_xscale, image_yscale, 90 + image_angle, image_blend, image_alpha);
		draw_sprite_ext(sprite_index, image_index, x, y + 16 * image_yscale, image_xscale, image_yscale, 270 + image_angle, image_blend, image_alpha);
	}
}

draw_funcs[$ objSpikeDiamondHorizontal] = function () {
	if (image_angle != start_angle) {
	    draw_sprite_ext(sprite_index, image_index, x + pivot_pos_x(-xoff_combo + (xcen / 2), -xoff_combo, image_angle), y + pivot_pos_y(-yoff_combo + (ycen / 2), -yoff_combo, image_angle), image_xscale, image_yscale, 0+  image_angle, image_blend, image_alpha);
	    draw_sprite_ext(sprite_index, image_index, x + pivot_pos_x(-xoff_combo - (xcen / 2), -xoff_combo, image_angle), y + pivot_pos_y(-yoff_combo - (ycen / 2), -yoff_combo, image_angle), image_xscale, image_yscale, 180 + image_angle, image_blend, image_alpha);
	} else {
		draw_sprite_ext(sprite_index, image_index, x + 16 * image_xscale, y, image_xscale, image_yscale, 0 + image_angle, image_blend, image_alpha);
		draw_sprite_ext(sprite_index, image_index, x - 16 * image_xscale, y, image_xscale, image_yscale, 180 + image_angle, image_blend, image_alpha);
	}
}

draw_funcs[$ objSpikeShuriken] = function () {
	type = string_split(sprite_get_name(sprite_index), "_")[1];
	block = block_sprite;
	if (sprite_exists(asset_get_index("sprBlock_" + type))) {
		block = asset_get_index("sprBlock_" + type);
	}
	
	if (image_angle != start_angle) {
		draw_sprite_ext(block, 0, x + pivot_pos_x(-xoff_block, -xoff_block, image_angle), y + pivot_pos_y(-yoff_block, -yoff_block, image_angle), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
	    draw_sprite_ext(sprite_index, image_index, x + pivot_pos_x(-xoff_combo + xcen, -xoff_combo, image_angle), y + pivot_pos_y(-yoff_combo + ycen, -yoff_combo, image_angle), image_xscale, image_yscale, 0 + image_angle, image_blend, image_alpha);
	    draw_sprite_ext(sprite_index, image_index, x + pivot_pos_x(-xoff_combo, -xoff_combo - xcen, image_angle), y + pivot_pos_y(-yoff_combo, -yoff_combo - ycen, image_angle), image_xscale, image_yscale, 90 + image_angle, image_blend, image_alpha);
	    draw_sprite_ext(sprite_index, image_index, x + pivot_pos_x(-xoff_combo - xcen, -xoff_combo, image_angle), y + pivot_pos_y(-yoff_combo - ycen, -yoff_combo, image_angle), image_xscale, image_yscale, 180 + image_angle, image_blend, image_alpha);
	    draw_sprite_ext(sprite_index, image_index, x + pivot_pos_x(-xoff_combo, -xoff_combo + xcen, image_angle), y + pivot_pos_y(-yoff_combo, -yoff_combo + ycen, image_angle), image_xscale, image_yscale, 270 + image_angle, image_blend, image_alpha);
	} else {
		draw_sprite_ext(block, 0, x - 16 * image_xscale, y - 16 * image_yscale, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
		draw_sprite_ext(sprite_index, image_index, x + 32 * image_xscale, y, image_xscale, image_yscale, 0 + image_angle, image_blend, image_alpha);
		draw_sprite_ext(sprite_index, image_index, x, y - 32 * image_yscale, image_xscale, image_yscale, 90 + image_angle, image_blend, image_alpha);
		draw_sprite_ext(sprite_index, image_index, x - 32 * image_xscale, y, image_xscale, image_yscale, 180 + image_angle, image_blend, image_alpha);
		draw_sprite_ext(sprite_index, image_index, x, y + 32 * image_yscale, image_xscale, image_yscale, 270 + image_angle, image_blend, image_alpha);
	}
}

draw_funcs[$ objSpikeBlock] = function () {
	if (image_angle != start_angle) {
		draw_sprite_ext(sprite_index, image_index, x - pivot_pos_x(-xoff_block, -xoff_block, image_angle), y - pivot_pos_y(-yoff_block, -yoff_block, image_angle), image_xscale, image_yscale, 90 + image_angle, image_blend, image_alpha);
		draw_sprite_ext(sprite_index, image_index, x - pivot_pos_x(-xoff_block, -xoff_block, image_angle), y - pivot_pos_y(-yoff_block, -yoff_block, image_angle), image_xscale, image_yscale, 270 + image_angle, image_blend, image_alpha);
		draw_sprite_ext(sprite_index, image_index, x - pivot_pos_x(-xoff_block, -xoff_block, image_angle), y - pivot_pos_y(-yoff_block, -yoff_block, image_angle), image_xscale, image_yscale, 180 + image_angle, image_blend, image_alpha);
		draw_sprite_ext(sprite_index, image_index, x - pivot_pos_x(-xoff_block, -xoff_block, image_angle), y - pivot_pos_y(-yoff_block, -yoff_block, image_angle), image_xscale, image_yscale, 0 + image_angle, image_blend, image_alpha);
	} else {
		draw_sprite_ext(sprite_index, image_index, x + sprite_width / 2, y + sprite_height / 2, image_xscale, image_yscale, 90 + image_angle, image_blend, image_alpha);
		draw_sprite_ext(sprite_index, image_index, x + sprite_width / 2, y + sprite_height / 2, image_xscale, image_yscale, 270 + image_angle, image_blend, image_alpha);
		draw_sprite_ext(sprite_index, image_index, x + sprite_width / 2, y + sprite_height / 2, image_xscale, image_yscale, 180 + image_angle, image_blend, image_alpha);
		draw_sprite_ext(sprite_index, image_index, x + sprite_width / 2, y + sprite_height / 2, image_xscale, image_yscale, 0 + image_angle, image_blend, image_alpha);		
	}
} 
#endregion

#region Other Spikes
draw_funcs[$ objSpikeRotate] = function() {
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}
#endregion

draw_func = draw_funcs[$ object_index];