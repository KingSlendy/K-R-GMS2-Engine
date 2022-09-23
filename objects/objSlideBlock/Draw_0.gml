var xscale = image_xscale;
if (hspd != 0) { 
	xscale = abs(image_xscale) * sign(hspd);
}

var yscale = image_yscale;
if (vspd != 0) {
	yscale = abs(image_yscale) * sign(vspd);
}

draw_sprite_ext(sprite_index, image_index, x, y, xscale, yscale, image_angle, image_blend, image_alpha);