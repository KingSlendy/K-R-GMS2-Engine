status = 0;

function battle_win() {
	if (num > -1) {
	    global.monsters_mtg[num] = true;
		global.experience_gain += floor(experience * (1.5 * (global.items_mtg.special[15])));
	}
	audio_play_sound(sndDeath, 0, false);
    instance_destroy();
}