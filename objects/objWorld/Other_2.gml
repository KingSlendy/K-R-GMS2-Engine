audio_group_load(audiogroup_BGM);
audio_group_load(audiogroup_SFX);
load_config();
time_micro = 0;
instance_create_depth(0, 0, depth, objTriggerController);

alarm[0] = 1;