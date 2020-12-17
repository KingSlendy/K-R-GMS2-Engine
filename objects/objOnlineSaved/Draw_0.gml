var __ONLINE_xx = 20;
var __ONLINE_yy = 20;

if (view_enabled && view_visible[0]) {
	var __ONLINE_cam = camera_properties(0);
	__ONLINE_xx += __ONLINE_cam.view_x;
	__ONLINE_yy += __ONLINE_cam.view_y;
}

var __ONLINE_text = __ONLINE_name + " saved!";
var __ONLINE__alpha = draw_get_alpha();
var __ONLINE__color = draw_get_color();
draw_set_alpha(image_alpha);
draw_set_font(fntMenu3);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text_outline(__ONLINE_xx, __ONLINE_yy, __ONLINE_text, c_black);
draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_color(__ONLINE__color);
draw_set_alpha(__ONLINE__alpha);