#region Controls Config
global.controls = {
	left: vk_left,
	right: vk_right,
	up: vk_up,
	down: vk_down,
	jump: vk_shift,
	shoot: ord("Z"),
	restart: ord("R"),
	pause: ord("P")
};

global.controls_menu = {
	left: vk_left,
	right: vk_right,
	up: vk_up,
	down: vk_down,
	accept: vk_shift,
	back: ord("Z"),
	options: vk_enter
};

global.controls_misc = {
	fullscreen: vk_f4,
	reset: vk_f2,
	quit: vk_escape
};

function is_held(control) {
	return keyboard_check(control);
}

function is_pressed(control) {
	return keyboard_check_pressed(control);
}

function is_released(control) {
	return keyboard_check_released(control);
}
#endregion

#region Window Config
global.display = {
	vol: 1,
	fullscreen: false,
	vsync: false,
	smooth: false
};

load_config();
#endregion