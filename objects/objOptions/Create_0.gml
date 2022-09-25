function Option(label, on_select, get_value) constructor {
	self.label = label;
	self.on_select = on_select;
	self.get_value = get_value;
}

options = [
	[ //Options
		new Option("Music: ", function() {
			global.display.mute_music ^= true;
			toggle_music();
		}, function() {
			return (global.display.mute_music) ? "No" : "Yes";
		}),

	
		new Option("Master Volume: ", function() {
			var dir = (is_held(global.controls_menu.right) - is_held(global.controls_menu.left));
			
			if (dir != 0) {
				change_volume();
			}
		}, function() {
			return string_interp("{0}%", ceil(global.display.master_volume * 100));
		}),
		
		new Option("BGM Volume: ", function() {
			var dir = (is_held(global.controls_menu.right) - is_held(global.controls_menu.left));
			
			if (dir != 0) {
				change_volume("bgm");
			}
		}, function() {
			return string_interp("{0}%", ceil(global.display.bgm_volume * 100));
		}),
		
		new Option("SFX Volume: ", function() {
			var dir = (is_held(global.controls_menu.right) - is_held(global.controls_menu.left));
			
			if (dir != 0) {
				change_volume("sfx");
			}
		}, function() {
			return string_interp("{0}%", ceil(global.display.sfx_volume * 100));
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
		
		new Option("Reset Defaults", function() {
			scrOptionsConfig();
			toggle_music();
			set_display();
		}, function() {
			return "";
		}),
		
		new Option("Change Controls", function() {
			menu = MENU_OPTIONS.CONTROLS;
			audio_play_sound(sndJump, 0, false);
		}, function() {
			return "";
		}),
		
		new Option("Online Connection", function() {
			menu = MENU_OPTIONS.ONLINE;
			audio_play_sound(sndJump, 0, false);
		}, function() {
			return "";
		})
	],
	
	[ //Controls
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
	],
	
	[ //Online
		new Option("Status: ", function() {
			global.connected ^= true;
			
			if (global.connected) {
				objWorld.online_connect();
			} else {
				objWorld.online_disconnect();
			}
		}, function() {
			return (global.connected) ? "Online" : "Offline";
		}),
		
		new Option("Name: ", function() {
			var name = get_string("Input name", "");
			name = string_replace(name, "\n", "\\n");
			
			if (name == "") {
				name = "Anonymous";
			}
			
			global.online.name = string_copy(name, 0, 20);
		}, function() {
			return global.online.name;
		}),
		
		new Option("Password: ", function() {
			var password = get_string("Input password", global.online.password);
			password = string_replace(password, "\n", "\\n");
			global.online.password = string_copy(password, 0, 20);
		}, function() {
			return global.online.password;
		}),
		
		new Option("Race: ", function() {
			global.online.race ^= true;
		}, function() {
			return (global.online.race) ? "Yes" : "No";
		}),
		
		new Option("Server: ", function() {
			global.online.server = get_string("Enter new server", global.online.server);
		}, function() {
			return global.online.server;
		}),
		
		new Option("TCP Port: ", function() {
			global.online.tcp = get_integer("Enter TCP port", 3003);
		}, function() {
			return string(global.online.tcp);
		}),
		
		new Option("UDP Port: ", function() {
			global.online.udp = get_integer("Enter UDP port", 3005);
		}, function() {
			return string(global.online.udp);
		}),
		
		new Option("Reset Defaults", function() {
			global.connected = false;
			scrOnlineConfig();
		}, function() {
			return "";
		})
	]
];

enum MENU_OPTIONS {
	OPTIONS,
	CONTROLS,
	ONLINE
}

menu = MENU_OPTIONS.OPTIONS;
select = array_create(array_length(options), 0);
spacing = 50;
changing_controls = false;