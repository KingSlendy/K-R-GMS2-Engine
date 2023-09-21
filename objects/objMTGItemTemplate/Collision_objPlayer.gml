if (num > -1) {
	global.items_mtg[$ type][num] = true;
			
	var text_amount = (object_index == objMTGKey) ? amount : amount[image_index];
	if (text_amount > 0) {
		text = instance_create_depth(x - sprite_width / 2, y - sprite_height, depth, objMTGAmountText);
		text.amount = text_amount;
	}
}

if (global.auto_save_items) {
	save_game(false);
}

audio_play_sound(sndItem, 0, false);
instance_destroy();