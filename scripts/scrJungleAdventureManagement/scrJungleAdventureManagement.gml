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
			struct_set_all(vine_mod, 0);
		}
		break;
	}
}