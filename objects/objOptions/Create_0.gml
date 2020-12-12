function Option(label, on_select, get_value) constructor {
	self.label = label;
	self.on_select = on_select;
	self.get_value = get_value;
}

options = {
	menu: [
		new Option("Volume: ", function() {
			var dir = (is_held(global.controls_menu.right) - is_held(global.controls_menu.left));
			
			if (dir != 0) {
				change_volume();
			}
		}, function() {
			return string_interp("{0}%", ceil(global.display.vol * 100));
		}),
		
		new Option("Fullscreen: ", function() {
			global.display.fullscreen ^= true;
			set_display();
		}, function() {
			return (global.display.fullscreen) ? "Yes" : "No";
		}),
		
		new Option("VSync: ", function() {
			global.display.vsync ^= true;
			set_display();
		}, function() {
			return (global.display.vsync) ? "Yes" : "No";
		}),
		
		new Option("Smooth Mode: ", function() {
			global.display.smooth ^= true;
			set_display();
		}, function() {
			return (global.display.smooth) ? "Yes" : "No";
		}),
		
		new Option("Reset Defaults", function() {
			scrOptionsConfig();
			set_display();
		}, function() {
			return "";
		}),
		
		new Option("Change Controls", function() {
			menu = 1;
			audio_play_sound(sndJump, 0, false);
		}, function() {
			return "";
		})
	],
	
	controls: [
		"Left",
		"Right",
		"Up",
		"Down",
		"Jump",
		"Shoot",
		"Restart",
		"Pause",
		new Option("Reset Defaults", function() {
			scrControlsConfig();
		}, function() {
			return "";
		})
	]
};

menu = 0;
select = array_create(2, 0);
spacing = 50;
changing_controls = false;