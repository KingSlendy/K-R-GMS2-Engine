draw_set_font(fntMenu3);
var __ONLINE_textHeight = string_height_ext(__ONLINE_message, __ONLINE_sep, __ONLINE_maxTextWidth);
var __ONLINE_height = __ONLINE_textHeight + 2 * __ONLINE_paddingText;
var __ONLINE_yOffset = -__ONLINE_height / 2 + 60;
var __ONLINE_left = 0;
var __ONLINE_right = room_width;
var __ONLINE_top = 0;
var __ONLINE_bottom = room_height;

if (view_enabled && view_visible[0]) {
	var __ONLINE_cam = camera_properties(0);
	__ONLINE_left = __ONLINE_cam.view_x;
	__ONLINE_right = __ONLINE_left + __ONLINE_cam.view_w;
	__ONLINE_top = __ONLINE_cam.view_y;
	__ONLINE_bottom = __ONLINE_top + __ONLINE_cam.view_h;
}

var __ONLINE_xx = min(max(x, __ONLINE_left+__ONLINE_width/2+__ONLINE_padding), __ONLINE_right-__ONLINE_width/2-__ONLINE_padding);
var __ONLINE_yy = min(max(y-__ONLINE_yOffset, __ONLINE_top+__ONLINE_height/2+__ONLINE_padding), __ONLINE_bottom-__ONLINE_height/2-__ONLINE_padding);
var __ONLINE__alpha = draw_get_alpha();
var __ONLINE__color = draw_get_color();

draw_set_alpha(min(__ONLINE_alpha, __ONLINE_fadeAlpha));
draw_set_color(c_white);
draw_rectangle(__ONLINE_xx-__ONLINE_width/2, __ONLINE_yy-__ONLINE_height/2, __ONLINE_xx+__ONLINE_width/2, __ONLINE_yy+__ONLINE_height/2, false);
draw_set_color(c_black);
draw_rectangle(__ONLINE_xx-__ONLINE_width/2, __ONLINE_yy-__ONLINE_height/2, __ONLINE_xx+__ONLINE_width/2, __ONLINE_yy+__ONLINE_height/2, true);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_ext(__ONLINE_xx, __ONLINE_yy, __ONLINE_message, __ONLINE_sep, __ONLINE_maxTextWidth);
draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_color(__ONLINE__color);
draw_set_alpha(__ONLINE__alpha);