#region Pause Overlay
if (global.game_paused) {
	draw_sprite(pause_screen, 0, 0, 0);
	
	draw_set_alpha(0.4);
	draw_set_color(c_black);
	draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
	draw_set_alpha(1);
	
	draw_set_font(fntPause);
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(display_get_gui_width() / 2, display_get_gui_height() / 2, "PAUSED");
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	
	draw_set_font(fntPause2);
    draw_text(20, 516, string_interp("Master Volume: {0}%", ceil(global.display.master_volume * 100)));
    draw_text(20, 541, string_interp("Deaths: {0}", global.deaths));
    draw_text(20, 566, string_interp("Time: {0}", formatted_time(global.time)));
}
#endregion

#region Debug Overlay
if (global.debug_enable && global.debug_overlay) {
    var spacing = 16;
    draw_set_font(fntMenu3);
	draw_set_color(c_white);

    if (global.game_started) {
        var xx = "N/A";
        var yy = "N/A";
        var align = "N/A";
        
        if (instance_exists(objPlayer)) {
            xx = objPlayer.x;
            yy = objPlayer.y;
            align = xx % 3;
        }
		
		var info = [
			string_interp("Player (X, Y, Align, Grav): ({0}, {1}, {2}, {3})", xx, yy, align, global.grav),
			string_interp("Room: {0}", room_get_name(room)),
			string_interp("FPS: {0}", fps),
			string_interp("FPS real: {0}", fps_real),
			string_interp("Object counter: {0}", instance_count)
		];
		
		var length = array_length(info);
		
		for (var i = 0; i < length; i++) {
			draw_text_outline(0, spacing * i, info[i], c_black);
		}
    } else {
		draw_set_color(c_red);
        draw_text_outline(0, 0, "Debug Mode", c_black);
    }
}
#endregion