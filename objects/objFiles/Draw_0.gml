for (var i = 0; i < global.total_saves; i++) {
	var data = datas[i];
    draw_sprite(sprFilesBar, 0, x - 32, y + spacing * i);
	
	//Name
    draw_set_alpha(1);
	draw_set_font(fntMenu);
    draw_set_color(c_black);
	draw_set_halign(fa_left);
    draw_text(x, y + spacing * i, string_interp("Data{0}", i + 1));
    
	//Difficulty
	draw_set_font(fntMenu2);
	draw_set_halign(fa_center);
    
    var draw_diff = data.difficulty;
    
    if (menu == 1 && select[0] == i) {
        draw_diff = string_interp("< {0} >", global.difficulties[select[menu]]);
    }
    
    draw_text(x + 48, y + 46 + spacing * i, draw_diff);
    
	//Deaths and Time
	draw_set_font(fntMenu3);
    draw_set_halign(fa_left);
    draw_text(x, y + 78 + spacing * i, string_interp("Deaths: {0}", data.deaths));
    draw_text(x, y + 100 + spacing * i, string_interp("Time: {0}", formatted_time(data.time)));
    
    //for (var j = 0; j < global.totalItems; j++) {
        //draw_sprite_ext(itemsImages[j], 0, x + 160 + 32 * j, y + 16 + spacing * i, 1, 1, 0, cond_exp(items[i, j], c_white, c_black), 1);
    //}
    
    //for (var j = 0; j < global.totalBossItems; j++) {
        //draw_sprite_ext(bossItemsImages[j], 0, x + 160 + 32 * j, y + 48 + spacing * i, 1, 1, 0, cond_exp(bossItems[i, j], c_white, c_black), 1);
    //}
        
    if (data.clear) {
		draw_set_font(fntMenu4);
        draw_set_halign(fa_center);
        draw_text(x + 284, y + 92 + spacing * i, "Clear!");
    }
        
    if (select[0] == i) {
        draw_sprite(sprCherry, 0, 48, y + 60 + spacing * i);
        draw_sprite(sprCherry, 0, room_width - 56, y + 60 + spacing * i);
    }
}

draw_set_font(fntMenu3);
draw_set_halign(fa_center);
draw_text(225, 550, "[Z] Back");
draw_text(380, 550, "[Enter] Options");
draw_text(550, 550, "[Shift] Accept");