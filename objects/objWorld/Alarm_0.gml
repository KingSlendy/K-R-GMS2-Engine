if (!audio_group_is_loaded(audiogroup_BGM) || !audio_group_is_loaded(audiogroup_SFX)) {
	alarm[0] = 1;
	exit;
}

room_goto_next();