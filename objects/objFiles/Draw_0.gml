for (var i = 0; i < global.total_saves; i++) {
	var data = datas[i];
    draw_sprite(sprFilesBar, 0, x - 32, y + spacing * i);
	
	//Name
    draw_set_alpha(1);
	draw_set_font(fntMenu);
    draw_set_color(c_white);
	draw_set_halign(fa_left);
    draw_text_outline(x, y + spacing * i, $"Data{i + 1}", c_black);
    
	//Difficulty
	draw_set_font(fntMenu2);
	draw_set_halign(fa_center);
    
    var draw_diff = data.difficulty;
    
    if (menu == 1 && select[0] == i) {
        draw_diff = $"< {global.difficulties[select[menu]]} >";
    }
    
    draw_text_outline(x + 48, y + 46 + spacing * i, draw_diff, c_black);
    
	//Deaths and Time
	draw_set_font(fntMenu3);
    draw_set_halign(fa_left);
    draw_text_outline(x, y + 78 + spacing * i, $"Deaths: {data.deaths}", c_black);
    draw_text_outline(x, y + 100 + spacing * i, $"Time: {formatted_time(data.time)}", c_black);
    
	//Secrets and Bosses
    for (var j = 0; j < array_length(global.items.secrets); j++) {
        draw_sprite_ext(images_secrets[j], 0, x + 160 + 32 * j, y + 16 + spacing * i, 1, 1, 0, (data.items.secrets[j]) ? c_white : c_black, 1);
    }
    
    for (var j = 0; j < array_length(global.items.bosses); j++) {
        draw_sprite_ext(images_bosses[j], 0, x + 160 + 32 * j, y + 48 + spacing * i, 1, 1, 0, (data.items.bosses[j]) ? c_white : c_black, 1);
    }
      
	//Clear
    if (data.clear) {
		draw_set_font(fntMenu4);
        draw_set_halign(fa_center);
        draw_text_outline(x + 284, y + 92 + spacing * i, "Clear!", c_black);
    }
        
    if (select[0] == i) {
        draw_sprite(sprCherry, 0, 52, y + 60 + spacing * i);
        draw_sprite(sprCherry, 0, room_width - 56, y + 60 + spacing * i);
    }
}

draw_set_font(fntMenu3);
draw_set_halign(fa_center);
draw_text_outline(225, 550, "[Z] Back", c_black);
draw_text_outline(380, 550, "[Enter] Options", c_black);
draw_text_outline(550, 550, "[Shift] Accept", c_black);
draw_set_halign(fa_left);