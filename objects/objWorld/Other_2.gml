application_surface_draw_enable(false);
audio_group_load(audiogroup_BGM);
audio_group_load(audiogroup_SFX);
load_config();
time_micro = 0;

if (!instance_exists(objTriggerController)) {
	instance_create_depth(0, 0, depth, objTriggerController);
}