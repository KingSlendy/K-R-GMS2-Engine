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
	var dir = (is_held(global.controls.right) - is_held(global.controls.left));
	global.display.vol += 0.01 * dir;
	global.display.vol = clamp(global.display.vol, 0, 1);
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