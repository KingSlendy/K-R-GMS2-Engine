draw_set_font(fntOptions);
draw_set_color(c_white);

var option = options[menu];
var selected = select[menu];
var length = array_length(options[menu]);
var index = 0;

switch (menu) {
	case MENU_OPTIONS.CONTROLS:
		while (true) {
			var curr_option = option[index];
			
			//If the current option isn't a control anymore, exit the loop
			if (!is_string(curr_option)) {
				break;
			}
			
			var bind = control_bind(global.controls[$ string_lower(curr_option)]);
        
	        if (changing_controls && selected == index) {
	            bind = "---";
	        }
        
	        draw_text_outline(x, y + spacing * index, $"{curr_option} Button: {bind}", c_black);
			index++;
		}
		//Skips the "break" to ensure it draws all the subsequent options
		
	case MENU_OPTIONS.OPTIONS:
	case MENU_OPTIONS.ONLINE:
		//Draws all the options
		for (var i = index; i < length; i++) {
			var curr_option = option[i];
			draw_text_outline(x, y + spacing * i, curr_option.label + curr_option.get_value(), c_black);
		}
		break;
}

draw_sprite(sprCherry, 0, x - 20, y + 25 + spacing * selected);

draw_set_font(fntMenu3);
draw_set_halign(fa_center);
draw_text_outline(225, 550, "[Z] Back", c_black);
draw_text_outline(550, 550, "[Shift] Accept", c_black);
draw_set_halign(fa_left);