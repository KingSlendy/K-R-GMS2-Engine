if (global.game_started) {
    restart_game();
    save_game(false);
	global.game_started = false;
}

save_config();

#region Online
online_disconnect();
buffer_delete(__ONLINE_buffer);
#endregion