#region Required enemies killed
if (num > -1) {// && array_length(global.monsters_mtg) > 0 && array_length(need_mobs) > 0) {
	/*for (var i = 0; i < array_length(need_mobs); i++) {
		if (!global.monsters_mtg[i]) {
			exit;
		}
	}*/
	
	//global.items_mtg[$ type][num] = true;
	opened = true;
}
#endregion

#region Door Opening
if (opened) {
	door_xoffset = approach(door_xoffset, sprite_width / 2, image_xscale / open_time);
	door_yoffset = approach(door_yoffset, sprite_height / 2, image_yscale / open_time);
	if (door_xoffset == sprite_width / 2 && door_yoffset == sprite_height / 2) {
		instance_destroy();
	}
}
#endregion