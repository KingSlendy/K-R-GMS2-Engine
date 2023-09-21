if (num > -1) {
	//global.items_mtg[$ type][num] = true;
	opened = true;
}


#region Door Opening
if (opened) {
	door_yoffset = approach(door_yoffset, sprite_height, image_yscale / open_time);
	if (door_yoffset == sprite_height) {
		instance_destroy();
	}
}
#endregion