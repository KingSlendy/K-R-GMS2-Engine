draw_set_font(fntOptions);
draw_set_color(c_black);

if (menu == 0) {
	var length = array_length(options.menu);
	
	for (var i = 0; i < length; i++) {
		var option = options.menu[i];
		draw_text(x, y + spacing * i, option.label + option.get_value());
	}
} else if (menu == 1) {
	var length = array_length(options.controls);
	
    for (var i = 0; i < length - 1; i++) {
        var bind = control_bind(variable_struct_get(global.controls, string_lower(options.controls[i])));
        
        if (changing_controls && select[menu] == i) {
            bind = "---";
        }
        
        draw_text(x, y + spacing * i, string_interp("{0} Button: {1}", options.controls[i], bind));
    }

    draw_text(x, y + spacing * (length - 1), options.controls[length - 1].label);
}

draw_sprite(sprCherry, 0, x - 20, y + 25 + spacing * select[menu]);

draw_set_font(fntMenu3);
draw_set_halign(fa_center);
draw_text(225, 550, "[Z] Back");
draw_text(550, 550, "[Shift] Accept");
draw_set_halign(fa_left);