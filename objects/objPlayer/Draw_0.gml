#region Color
if ((global.debug_enable && global.debug_coloring) && global.debug_inf_jump) {
    image_blend = c_blue;
} else {
	if (global.forms.dotkid) {
		image_blend = c_red;
	} else {
		image_blend = c_white;
	}
}

if (global.forms.vkid = 1) { 
	image_blend = make_color_rgb(1,164,217); 
} else if (global.forms.vkid = 2) { 
	image_blend = make_color_rgb(164,1,171); 
}
#endregion

#region Draw Variables
var draw_y = y;
var player_xscale = image_xscale;
var player_yscale = image_yscale;

if (!global.forms.dotkid && !global.forms.lunarkid && !global.forms.linekid) {
	if (global.grav == -1) {
		draw_y++;
	}
	player_xscale = image_xscale * xscale;
	player_yscale = image_yscale * global.grav;
}
#endregion

#region Skin
if (global.debug_hitbox != 2) {
	if (global.forms.vkid > 0 || global.forms.telekid) {
		draw_sprite_fog(sprite_index, image_index, x, draw_y, player_xscale, player_yscale, image_angle, image_blend, image_alpha, image_blend);
	} else {
		draw_sprite_ext(sprite_index, image_index, x, draw_y, player_xscale, player_yscale, image_angle, image_blend, image_alpha);
	}
}
#endregion

#region Equip
if (!global.forms.lunarkid) {
	if ((global.difficulty == 0 && global.use_bow) || global.debug_god_mode) {
		draw_sprite_ext(sprBow, -1, x, y, xscale, global.grav, image_angle, c_white, 1);
	}
} else {
	if (!lunar_start || global.debug_god_mode) {
		draw_sprite_ext(sprLanders, -1, x, y, 1, 1, image_angle, c_white, 1);
	}
}
#endregion

#region Debug 
if (global.debug_hitbox > 0) {
	draw_sprite_ext(mask_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_fuchsia, 0.5 * global.debug_hitbox);
}

if (hit > 0) {
	draw_sprite_ext(sprPlayerHit, -1, hit_x, hit_y, 1, 1, 0, c_white, hit / global.debug_hit_time);
}
#endregion