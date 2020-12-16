draw_set_font(fntOptions);
draw_set_color(c_black);

var length = array_length(options[menu]);

switch (menu) {
	case MENU_OPTIONS.OPTIONS:
	case MENU_OPTIONS.ONLINE:
		for (var i = 0; i < length; i++) {
			var option = options[menu][i];
			draw_text(x, y + spacing * i, option.label + option.get_value());
		}
		break;
	
	case MENU_OPTIONS.CONTROLS: 
	    for (var i = 0; i < length - 1; i++) {
	        var bind = control_bind(variable_struct_get(global.controls, string_lower(options[menu][i])));
        
	        if (changing_controls && select[menu] == i) {
	            bind = "---";
	        }
        
	        draw_text(x, y + spacing * i, string_interp("{0} Button: {1}", options[menu][i], bind));
	    }

	    draw_text(x, y + spacing * (length - 1), options[menu][length - 1].label);
		break;
}

draw_sprite(sprCherry, 0, x - 20, y + 25 + spacing * select[menu]);

draw_set_font(fntMenu3);
draw_set_halign(fa_center);
draw_text(225, 550, "[Z] Back");
draw_text(550, 550, "[Shift] Accept");
draw_set_halign(fa_left);