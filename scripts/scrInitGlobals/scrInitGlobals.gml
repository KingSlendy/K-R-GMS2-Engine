global.game_started = false; //Checks if you're already in-game
global.game_paused = false; //Checks if the game is paused
global.caption_last = ""; //Keeps track of the last caption

global.auto_save = false; //Sets if the game will save after spawning the player
global.save_num = 0; //The current save file
global.save_player = { //Keeping track of the last player properties for saving
	sroom: null,
	sx: -1,
	sy: -1,
	sangle: 0,
	sgrav: 1,
	sforms: 0,
};

global.difficulty = 0; //The difficulty selected
cleanup_game(); //Initialize the save variables

global.controls_reverse = false; //Sets if left and right should be swapped
global.controls_lock = { //Keeping track of which controls are unusable
	shoot: false,
	restart: false,
	pause: false,
	suicide: true
}

global.collision_type = 0; //The type of block collision to use for the player (0 == original, 1 == mace)
global.vine_toggle = false; //Toggles which type of twin vine is active

global.current_music = -1; //The current music playing
global.last_xscale = 1; //Last xscale the player had
global.overlay = false; //Sets if the information overlay is currently visible
global.connected = false; //Checks if you're currently connected to the online

randomize(); //Sets a random seed