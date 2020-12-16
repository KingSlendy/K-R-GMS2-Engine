function set_caption() {
	var caption = global.game_name;

	if (global.game_started) {
	    caption += string_interp(" - {0} | Deaths: {1} | Time: {2}",
		global.difficulties[global.difficulty],
	    global.deaths,
	    formatted_time(global.time));
	}

	if (caption != global.caption_last) {
	    window_set_caption(caption);
		global.caption_last = caption;
	}
}

function formatted_time(time) {
	var ss1 = time % 10;
	var ss2 = (time div 10) % 6;
	var mm1 = (time div 60) % 10;
	var mm2 = ((time div 60) div 10) % 6;
	var hh = (time div 60) div 60;

	return string_interp("{0}:{1}{2}:{3}{4}", hh, mm2, mm1, ss2, ss1);
}