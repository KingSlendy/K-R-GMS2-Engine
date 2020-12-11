if (global.game_started) {
    restart_game();
    save_game(false);
	global.game_started = false;
}

save_config();