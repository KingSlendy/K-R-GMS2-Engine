function cleanup_game() {
	global.grav = 1;
	global.deaths = 0;
	global.time = 0;
	global.clear = false;
}

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
			deaths: global.deaths,
			time: global.time,
			difficulty: global.difficulty,
			clear: global.clear
		}
	};
	
	var json = json_stringify(data);
	save_string(string_interp("Data{0}", global.save_num + 1), json);
}

function load_game(position) {
	if (instance_exists(objPlayer)) {
		instance_destroy(objPlayer);
	}
	
	var json = load_string(string_interp("Data{0}", global.save_num + 1));
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
	
}

function load_config() {
	
}