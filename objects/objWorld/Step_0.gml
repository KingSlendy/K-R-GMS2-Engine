#region Game Checks
audio_master_gain(global.display.vol);
gpu_set_texfilter(global.display.smooth);

if (global.time_when_dead || instance_exists(objPlayer)) {
    time_micro += delta_time;
    global.time += time_micro div 1000000;
    time_micro %= 1000000;
}

set_caption();
#endregion

#region Main Inputs
if (!global.game_paused) {
	if (is_pressed(global.controls.restart)) {
		restart_game();
	}
} else {
	change_volume();
}

if (pause_delay < global.total_pause_delay) {
	pause_delay++;
} else if (is_pressed(global.controls.pause)) {
	global.game_paused = !global.game_paused;
	
	if (global.game_paused) {
		pause_screen = sprite_create_from_surface(application_surface, 0, 0, view_wport[0], view_hport[0], false, false, 0, 0);
		instance_deactivate_all(true);
	} else {
		instance_activate_all();
		
		if (sprite_exists(pause_screen)) {
			sprite_delete(pause_screen);
		}
		
		io_clear();
	}
	
	pause_delay = 0;
}
#endregion

#region Misc. Inputs
if (!global.game_paused) {
	//Toggles fullscreen
	if (is_pressed(global.controls_misc.fullscreen)) {
		global.display.fullscreen ^= true;
		set_display();
		save_config();
	}

	//Reset game
	if (is_pressed(global.controls_misc.reset)) {
		game_restart();
	}
}

//Close game
if (is_pressed(global.controls_misc.quit)) {
	game_end();
}
#endregion

#region Debug Inputs
if (global.debug_enable) {
	if (is_pressed(global.controls_debug.overlay)) {
		global.debug_overlay ^= true;
	}
	
	if (is_pressed(global.controls_debug.god_mode)) {
		global.debug_god_mode ^= true;
	}
	
	if (is_pressed(global.controls_debug.inf_jump)) {
		global.debug_inf_jump ^= true;
	}
	
	if (instance_exists(objPlayer)) {
		if (global.debug_inf_jump) {
			with (objPlayer) {
				jump_total = -1;
			}
		}
	
		if (is_pressed(global.controls_debug.teleport)) {
			objPlayer.x = mouse_x;
			objPlayer.y = mouse_y;
		}
	
		if (is_pressed(global.controls_debug.save)) {
			save_game(true);
		}
		
		if (is_pressed(global.controls_debug.roomU)) {
			if (room_get_name(room_previous(room)) != "rInit") {
				instance_destroy(objPlayer);
				room_goto_previous();
			}
		}
		
		if (is_pressed(global.controls_debug.roomD)) {
			if (room != room_last) {
				instance_destroy(objPlayer);
				room_goto_next();
			}
		}
	}
}
#endregion