global.game_started = false;
global.game_paused = false;
global.caption_last = "";

global.auto_save = false;
global.save_num = 0;
global.save_player = {
	sroom: noone,
	sx: -1,
	sy: -1,
	sgrav: 1
};

global.difficulty = 0;
cleanup_game();

global.current_music = -1;

global.last_xscale = 1;
randomize();