function package_jungleadventure(load_type = undefined) {
	if (load_type == undefined) { exit; }
	
	switch(load_type) {
		case "vars": //load the Jungle Adventure variables
		vine_mod = {
			stick: 0,
			lowgrav: 0,
			fire: 0,
			twin: false,
			
			//Effects
			count: 0
		};
		break;
		
		case "player prestep": //Reset the active water modifiers
		if (on_block != null || on_platform) {
			vine_mod.stick = 0;
			vine_mod.lowgrav = 0;
			vine_mod.fire = 0;
			
			vine_mod.count = 0;
		}
		break;
	}
}