if (!is_held(vk_anykey)) {
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
}/* else if (menu == 1) {
    select[menu] += totalControls;
    select[menu] %= totalControls;
    
    /*if (scrButtonPressed(global.menuAcceptButton)) {
        if (select[menu] == 9) {
            scrDefaultControls();
            event_user(0);
            scrSaveConfig();
            audio_play_sound(sndJump, 0, false);
        } else {
            changingControls = true;
            audio_play_sound(sndJump, 0, false);
        }
    }

    if (is_pressed(global.controls_menu.back)) {
        menu = 0;
        audio_play_sound(sndJump, 0, false);
    }
}*/