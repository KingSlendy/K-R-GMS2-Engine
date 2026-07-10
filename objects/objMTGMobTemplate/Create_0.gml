status = 0;

function battle_win() {
	if (num > -1) {
	    global.monsters_mtg[num] = true;
	    var bonus_exp = (global.items_mtg.special[15]) ? 1.5 : 1;
		global.experience_gain += floor(experience * bonus_exp);
		with (objMTGStatusOverlay) {
			overlay_init();
		}
	}
	audio_play_sound(sndDeath, 0, false);
    instance_destroy();
}