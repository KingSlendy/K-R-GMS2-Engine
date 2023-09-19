#region Collisions
function block_sprite() {
	var type = "";
	var block_speed = 1;
	var block_image = 0;
	
	switch(room) {
		/* EXAMPLE USAGE //
		case rSampleRoom:
		type = "_GuyBrown";
		block_speed = 0;
		block_image = 0;
		break;
		*//////////////////
		
		
		
		default: //Always keep this at the bottom
		type = "_GuyMetal";
		block_speed = 0;
		block_image = 0;
		break;
	}
	
	#region Detect valid sprite
	if (type != null) {
		if (sprite_exists(asset_get_index("sprBlock" + type))) {
			sprite_index = asset_get_index("sprBlock" + type);
		} else {
			sprite_index = sprBlock_GuyMetal;
		}
	}
	#endregion
	
	image_speed = block_speed;
	image_index = block_image;	
}

function platform_sprite() {
	var type = "";
	var platform_speed = 1;
	var platform_image = 0;

	switch (room) {
		/* EXAMPLE USAGE //
		case rSampleRoom:
		type = "_Metroid";
		platform_speed = 0;
		platform_image = 0;
		break;
		*//////////////////
		
		
		
		default: //Always keep this at the bottom
		type = "";
		platform_speed = 0;
		platform_image = 0;
		break;
	}
	
	#region Detect valid sprite
	if (type != null) {
		if (sprite_exists(asset_get_index("sprMovingPlatform" + type))) {
		    sprite_index = asset_get_index("sprMovingPlatform" + type);
		} else {
		    sprite_index = sprMovingPlatform;
		}
	}
	#endregion

	image_speed = platform_speed;
	image_index = platform_image;
}
#endregion

#region Killers
function spike_sprite() {
	var type = "";
	var spike_speed = 1;
	var spike_image = 0;

	switch(room) {
		/* EXAMPLE USAGE //
		case rSampleRoom:
		type = "_HD";
		spike_speed = 1;
	    spike_image = irandom(35);
		*//////////////////
		
		case rTestMagicTower:
		type = "_MTG";
		spike_speed = 1;
		spike_image = 0;
		break;
		
		default: //Always keep this at the bottom
		type = "";
		spike_speed = 1;
		spike_image = 0;
		break;
	}
	
	#region Detect valid sprites
	var regstrg = ["Right", "Up", "Left", "Down"];
	var combostrg = ["DiamondVertical", "DiamondHorizontal", "Shuriken", "Block", "Rotate"];
	for (var i = 0; i < array_length(regstrg); i++) {
		if (object_index == asset_get_index("objSpike" + regstrg[i])) {
			if (sprite_exists(asset_get_index("sprSpike" + regstrg[i] + type))) {
				sprite_index = asset_get_index(("sprSpike" + regstrg[i]) + type);
			} else {
				sprite_index = asset_get_index("sprSpike" + regstrg[i]);
			}
		} else if (object_index == asset_get_index("objMiniSpike" + regstrg[i])) {
			if (sprite_exists(asset_get_index("sprMiniSpike" + regstrg[i] + type))) {
				sprite_index = asset_get_index(("sprMiniSpike" + regstrg[i]) + type);
			} else {
				if (sprite_exists(asset_get_index("sprSpike" + regstrg[i] + type))) {
					sprite_index = asset_get_index(("sprSpike" + regstrg[i]) + type);
				} else {
					sprite_index = asset_get_index("sprSpike" + regstrg[i]);
				}
			}
		}
	}
	for (var i = 0; i < array_length(combostrg); i++) {
		if (object_index == asset_get_index("objSpike" + combostrg[i])) {
			if (sprite_exists(asset_get_index("sprSpike" + type))) {
				sprite_index = asset_get_index("sprSpike" + type);
			} else {
				sprite_index = sprSpike;
			}
		}
	}
	#endregion
	
	image_speed = spike_speed;
	image_index = spike_image;
}

function fruit_sprite() {
	var type = "";
	var fruit_speed = 1;
	var fruit_image = 0;	
	
	switch(room) {
		/* EXAMPLE USAGE //
		case rSampleRoom:
		type = "White";
		fruit_speed = 1;
		fruit_image = 0;
		break;
		*//////////////////
		
		
		
		default: //Always keep this at the bottom
		type = "";
		fruit_speed = 1;
		fruit_image = 0;
		break;
	}
	
	#region Detect valid sprite
	if (sprite_exists(asset_get_index("sprCherry" + type))) {
	    sprite_index = asset_get_index("sprCherry" + type);
	} else {
	    sprite_index = sprCherry;
	}
	#endregion
	
	image_speed = fruit_speed;
	image_index = fruit_image;
}
#endregion