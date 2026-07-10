if (global.forms.linekid != image_index) {
	global.forms.linekid = image_index;
	var sound = (image_index == 0) ? sndGainForm : sndSwitchForm;
	audio_play_sound(sound, 0, false);
}