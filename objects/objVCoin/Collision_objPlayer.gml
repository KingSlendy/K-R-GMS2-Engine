if (global.forms.vkid != vkid) {
	global.forms.vkid = vkid;
	audio_play_sound(sndVCoin, 0, false);
	instance_destroy();
}