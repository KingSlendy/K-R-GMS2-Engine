if (global.forms.lunarkid != image_index) {
	global.forms.lunarkid = image_index;
	var sound = (image_index == 0) ? sndGainForm : sndSwitchForm;
	audio_play_sound(sound, 0, false);
	
	other.grav = 0;
	other.speed = 0;
}