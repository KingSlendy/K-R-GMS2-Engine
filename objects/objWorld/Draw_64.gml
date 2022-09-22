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
if (global.overlay) {
    var spacing = 20;
    draw_set_font(fntMenu3);
	draw_set_color(c_white);

    if (global.game_started) {
		#region Initialize Overlay Variables
        var xx = "N/A";
		var hspd = "N/A";
		
        var yy = "N/A";
        var vspd = "N/A";
		
		var align = "N/A";
        var align_relative = "N/A";
		
		var angle = "N/A";
		
		var grav = "N/A";
		var grav_dir = "N/A";
		#endregion
		
		#region Set Overlay Variables
        if (instance_exists(objPlayer)) {
            xx = objPlayer.x;
			hspd = objPlayer.hspd;
			
            yy = objPlayer.y;
            vspd = objPlayer.vspd;
			
			align = objPlayer.max_hspd % 3;
			align_relative = xx % 3;
			
			angle = objPlayer.image_angle;
			
			grav = objPlayer.grav_amount;
			grav_dir = objPlayer.gravity_direction;
        }
		#endregion
		
		#region Draw Overlay Info
		var info = [
			string_interp("FPS: {0} (real: {1})", fps, fps_real),
			string_interp("X: {0} (hspd: {1})", xx, hspd),
			string_interp("Y: {0} (vspd: {1})", yy, vspd),
			string_interp("Align: {0} (relative: {1})", align, align_relative),
			string_interp("Angle: {0}", angle),
			string_interp("Gravity: {0} (direction: {1})", grav, grav_dir),
			string_interp("Room: {0} (number: {1})", room_get_name(room), room),
			string_interp("Object counter: {0}", instance_count)
		];
		
		var length = array_length(info);
		if (!global.debug_enable) {
			length = 5;
		}
		
		for (var i = 0; i < length; i++) {
			draw_text_outline(20, 20 + spacing * i, info[i], c_black);
		}
		#endregion
    } else {
		draw_set_color(c_red);
        draw_text_outline(20, 20, "Debug Mode", c_black);
    }
}
#endregion