function active_save() {
	if (instance_exists(objPlayer) && global.grav == grav && image_index == 0) {
	    save_game(true, bbox_left + sprite_width / 2, bbox_top + sprite_height / 2);
		image_index = 1;
		alarm[0] = 40;
	}
}