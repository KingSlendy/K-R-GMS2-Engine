global.controls = {
	left: new Button(vk_left),
	right: new Button(vk_right),
	jump: new Button(vk_shift),
	shoot: new Button(ord("Z")),
	restart: new Button(ord("R")),
	pause: new Button(ord("P"))
};

global.misc_controls = {
	fullscreen: new Button(vk_f4),
	reset: new Button(vk_f2),
	quit: new Button(vk_escape)
};

function Button(button) constructor {
	self.button = button;
	
	is_held = function() {
		return keyboard_check(button);
	}
	
	is_pressed = function() {
		return keyboard_check_pressed(button);
	}
	
	is_released = function() {
		return keyboard_check_released(button);
	}
	
	get_bind = function() {
	}
}