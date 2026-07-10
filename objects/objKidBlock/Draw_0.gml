draw_self();

#region Draw variables
var draw_x = x + sprite_width / 2;
var draw_y = y + sprite_height / 2;
var draw_angle = 90 * abs(grav) - (90 * sign(grav));
#endregion

var sprite = sprPlayerIdle;

#region Offset
var xoff = (abs(grav) == 1) ? 1 : 2;
var yoff = (abs(grav) == 1) ? 2 : -1;
#endregion

#region Color
var draw_color = c_black;
if (abs(grav) == 1) {
	draw_color = (grav == 1) ? c_aqua : c_red;
} else if (abs(grav) == 2) {
	draw_color = (grav == 2) ? c_fuchsia : c_yellow;
}
#endregion

draw_sprite_fog(sprite, -1, draw_x + (xoff * abs(image_xscale)) * sign(grav), draw_y + (yoff * abs(image_yscale)) * sign(grav), abs(image_xscale), abs(image_yscale), draw_angle, draw_color, 188 / 255, draw_color);