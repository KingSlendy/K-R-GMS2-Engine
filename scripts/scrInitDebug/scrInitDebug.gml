//Debug variables
global.debug_enable = true; //Sets if the debug options should be enabled
global.debug_coloring = true; //Enables debug player coloring
global.debug_hitbox = 0; //Enables debug player hitbox display
global.debug_hit_time = 50; //Sets max time for the player to be intangible when hit

//Toggles
global.debug_god_mode = false; //Toggles invincibility
global.debug_inf_jump = false; //Toggles infinite jump

global.controls_debug = { //Debug controls
	god_mode: vk_home,
	inf_jump: vk_end,
	teleport: vk_tab,
	save: vk_insert,
	hitbox: vk_delete,
	roomU: vk_pageup,
	roomD: vk_pagedown,
	alignL: ord("A"),
	alignR: ord("D")
};