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

var length = array_length(options[menu]);

switch (menu) {
	case MENU_OPTIONS.OPTIONS:
		select[menu] += length;
	    select[menu] %= length;

	    if (is_pressed(global.controls_menu.accept) || select[menu] == 0) {
			options[menu][select[menu]].on_select();
		}
    
	    if (is_pressed(global.controls_menu.back)) {
	        save_config();
	        room_goto(rFiles);
	    }
		break;
		
	case MENU_OPTIONS.CONTROLS:
		select[menu] += length;
	    select[menu] %= length;
    
	    if (is_pressed(global.controls_menu.accept)) {
	        if (select[menu] == length - 1) {
	            options[menu][select[menu]].on_select();
	        } else {
	            changing_controls = true;
	        }
		
			audio_play_sound(sndJump, 0, false);
	    }

	    if (is_pressed(global.controls_menu.back)) {
	        menu = MENU_OPTIONS.OPTIONS;
	        audio_play_sound(sndJump, 0, false);
	    }
		break;
		
	case MENU_OPTIONS.ONLINE:
		select[menu] += length;
	    select[menu] %= length;
		
		if (is_pressed(global.controls_menu.accept)) {
			options[menu][select[menu]].on_select();
		}
		
		if (is_pressed(global.controls_menu.back)) {
	        menu = MENU_OPTIONS.OPTIONS;
	        audio_play_sound(sndJump, 0, false);
	    }
		break;
}