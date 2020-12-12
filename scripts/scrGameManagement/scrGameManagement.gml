function save_game(position) {
	if (position) {
		global.save_player.sroom = room_get_name(room);
		global.save_player.sx = objPlayer.x;
		global.save_player.sy = objPlayer.y;
		global.save_player.sgrav = global.grav;
	}
	
	var data = {
		player: global.save_player,
		info: {
			difficulty: global.difficulty,
			deaths: global.deaths,
			time: global.time,
			clear: global.clear
		}
	};
	
	var json = json_stringify(data);
	save_string(string_interp("Data{0}", global.save_num + 1), json, true);
}

function load_game(position) {
	if (instance_exists(objPlayer)) {
		instance_destroy(objPlayer);
	}
	
	var json = load_string(string_interp("Data{0}", global.save_num + 1), true);
	var data = json_parse(json);
	
	global.save_player = data.player;
	global.deaths = data.info.deaths;
	global.time = data.info.time;
	global.difficulty = data.info.difficulty;
	global.clear = data.info.clear;
	
	if (position) {
		global.game_started = true;
		global.auto_save = false;
		global.grav = global.save_player.sgrav;
		instance_create_layer(global.save_player.sx, global.save_player.sy, "Instances", objPlayer);
	
		var get_room = global.save_player.sroom;
		
		if (room != get_room) {
			room_goto(asset_get_index(get_room));
		} else {
			room_restart();
		}
	}
}

function cleanup_game() {
	global.grav = 1;
	global.deaths = 0;
	global.time = 0;
	global.clear = false;
}

function start_game(diff) {
	var save = string_interp("Data{0}", global.save_num);
	var length = array_length(global.difficulties);

	if (diff == length - 1) {
	    load_game(true);
	} else {
		diff = clamp(diff, 0, length - 1);

	    if (file_exists(save)) {
	        file_delete(save);
	    }
        
	    global.game_started = true;
	    global.auto_save = true;
	    global.difficulty = diff;

	    instance_destroy(objPlayer);
	    room_goto(global.start_room);
	}
}

function restart_game() {
	if (global.death_music) {
	    audio_stop_sound(bgmGameOver);
	    audio_resume_sound(global.current_music);
	}
	
	var deaths = global.deaths;
	var time = global.time;
	load_game(true);
	global.deaths = deaths;
	global.time = time;
}

function save_config() {
	var data = {
		controls: global.controls,
		display: global.display
	};
	
	var json = json_stringify(data);
	save_string("Config.ini", json, false);
}

function load_config() {
	if (!file_exists("Config.ini")) {
		save_config();
	}
	
	var json = load_string("Config.ini", false);
	var data = json_parse(json);
	
	global.controls = data.controls;
	global.display = data.display;
	
	set_display();
}

function set_display() {
	window_set_fullscreen(global.display.fullscreen);
	
	if (global.display.vsync) {
		display_reset(0, global.display.vsync);
	}
	
	display_set_gui_size(surface_get_width(application_surface), surface_get_height(application_surface));
}

function change_volume() {
	var dir = (is_held(global.controls.right) - is_held(global.controls.left));
	global.display.vol += 0.01 * dir;
	global.display.vol = clamp(global.display.vol, 0, 1);
}