grav = 1;

function active_save() {
	if (instance_exists(objPlayer) && global.grav == grav && image_index == 0) {
	    save_game(true);
		image_index = 1;
		alarm[0] = 40;
	}
}