if (!is_held(vk_anykey)) {
	exit;
}

if (changing_controls && is_pressed(vk_anykey)) {
	var key = keyboard_key;
    
    if (key == 160 || key == 161) {
        key = 16;
    }
    
	variable_struct_set(global.controls, string_lower(options.controls[select[menu]]), key);
    save_config();
    audio_play_sound(sndJump, 0, false);
    changing_controls = false;
	exit;
}

if (is_pressed(global.controls_menu.up)) {
    select[menu]--;
    audio_play_sound(sndDoubleJump, 0, false);
}

if (is_pressed(global.controls_menu.down)) {
    select[menu]++;
    audio_play_sound(sndDoubleJump, 0, false);
}

if (menu == 0) {
    select[menu] += array_length(options.menu);
    select[menu] %= array_length(options.menu);

    if (is_pressed(global.controls_menu.accept) || select[menu] == 0) {
		options.menu[select[menu]].on_select();
	}
    
    if (is_pressed(global.controls_menu.back)) {
        save_config();
        room_goto(rFiles);
    }
} else if (menu == 1) {
    select[menu] += array_length(options.controls);
    select[menu] %= array_length(options.controls);
    
    if (is_pressed(global.controls_menu.accept)) {
        if (select[menu] == array_length(options.controls) - 1) {
            options.controls[select[menu]].on_select();
        } else {
            changing_controls = true;
        }
		
		audio_play_sound(sndJump, 0, false);
    }

    if (is_pressed(global.controls_menu.back)) {
        menu = 0;
        audio_play_sound(sndJump, 0, false);
    }
}