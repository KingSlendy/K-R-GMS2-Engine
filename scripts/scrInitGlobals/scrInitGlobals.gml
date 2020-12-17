global.game_started = false; //Checks if you're already in-game
global.game_paused = false; //Checks if the game is paused
global.caption_last = ""; //Keeps track of the last caption

global.auto_save = false; //Sets if the game will save after spawning the player
global.save_num = 0; //The current save file
global.save_player = { //Keeping track of the last player properties for saving
	sroom: noone,
	sx: -1,
	sy: -1,
	sgrav: 1
};

global.difficulty = 0; //The difficulty selected
cleanup_game(); //Initialize the save variables

global.current_music = -1; //The current music playing
global.last_xscale = 1; //Last xscale the player had
global.connected = false; //Checks if you're currently connected to the online

randomize(); //Sets a random seed