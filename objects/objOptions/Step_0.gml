if (!is_held(vk_anykey)) {
	exit;
}

if (changing_controls && is_pressed(vk_anykey)) {
	var key = keyboard_key;
    
    if (key == 160 || key == 161) {
        key = 16;
    }
    
	variable_struct_set(global.controls, string_lower(options[MENU_OPTIONS.CONTROLS][select[menu]]), key);
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
select[menu] += length;
select[menu] %= length;
var option = options[menu];
var selected = select[menu];

switch (menu) {
	case MENU_OPTIONS.OPTIONS:
	    if (is_pressed(global.controls_menu.accept) || selected > 0 && selected <= 3) {
			option[selected].on_select();
		}
    
	    if (is_pressed(global.controls_menu.back)) {
	        save_config();
	        room_goto(rFiles);
	    }
		break;
		
	case MENU_OPTIONS.CONTROLS:
	    if (is_pressed(global.controls_menu.accept)) {
	        if (selected == length - 1) {
	            option[selected].on_select();
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
		if (is_pressed(global.controls_menu.accept)) {
			option[selected].on_select();
		}
		
		if (is_pressed(global.controls_menu.back)) {
	        menu = MENU_OPTIONS.OPTIONS;
	        audio_play_sound(sndJump, 0, false);
	    }
		break;
}