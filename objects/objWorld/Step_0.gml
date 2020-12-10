#region Game Checks
if (global.time_when_dead || instance_exists(objPlayer)) {
    time_micro += delta_time;
    global.time += time_micro div 1000000;
    time_micro %= 1000000;
}

set_caption();
#endregion

#region Main Inputs
if (global.controls.restart.is_pressed()) {
	restart_game();
}

if (pause_delay < global.total_pause_delay) {
	pause_delay++;
} else if (global.controls.pause.is_pressed()) {
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
//Returns to the title screen
if (global.misc_controls.reset.is_pressed()) {
	game_restart();
}

//Closes the game
if (global.misc_controls.quit.is_pressed()) {
	game_end();
}
#endregion