//Debug variables
global.debug_enable = true; //Sets if the debug options should be enabled
global.debug_overlay = false; //Enables debug overlay
global.debug_coloring = true; //Enables debug player coloring

//Toggles
global.debug_god_mode = false; //Toggles invincibility
global.debug_inf_jump = false; //Toggles infinite jump

global.controls_debug = { //Debug controls
	overlay: vk_backspace,
	god_mode: ord("G"),
	inf_jump: ord("I"),
	teleport: vk_tab,
	save: vk_enter,
	roomU: vk_pageup,
	roomD: vk_pagedown,
	alignL: ord("A"),
	alignR: ord("D")
};