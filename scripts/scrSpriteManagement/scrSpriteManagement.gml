function check_apply_asset(asset1, asset2) {
    var index = asset_get_index(asset1);
    return (index != -1) ? index : asset2;
}

#region Collisions
function block_sprite(me = true) {
	#region Initialize variables
	var type = "";
	
	var block_alt = sprBlock_GuyMetal;
	var block_speed = 1;
	var block_image = 0;
	#endregion
	
	#region Set the type
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
	#endregion
	
	#region Detect valid sprite
	var block = {
		sprite: check_apply_asset($"sprBlock{type}", block_alt),
		spd: block_speed,
		image: block_image
	}
	
	if (me) {
		sprite_index = block.sprite;
		image_speed = block.spd;
		image_index = block.image;
	}
	#endregion

	return block;
}

function platform_sprite(me = true) {
	#region Initialize variables
	var type = "";

	var plat_alt = sprMovingPlatform;
	var plat_speed = 1;
	var plat_image = 0;
	var plat_blend = c_white;
	#endregion

	#region Set the type
	switch (room) {
		/* EXAMPLE USAGE //
		case rSampleRoom:
			type = "_Metroid";
			plat_speed = 0;
			plat_image = 0;
			break;
		*//////////////////
		
		
		
		default: //Always keep this at the bottom
			type = "";
			plat_speed = 0;
			plat_image = 0;
			break;
	}
	#endregion
	
	#region Detect valid sprite
	var plat = {
		sprite: check_apply_asset($"sprMovingPlatform{type}", plat_alt),
		spd: plat_speed,
		image: plat_image,
		blend: plat_blend,
	};
	
	if (me) {
		sprite_index = plat.sprite;
		image_speed = plat.spd;
		image_index = plat.image;
		image_blend = plat.blend;
	}
	#endregion
	
	return plat;
}
#endregion

#region Killers
function spike_sprite(me = true) {
	#region Initialize variables
	var type = "";

	var spike_spr = -1;
	var spike_speed = 1;
	var spike_image = 0;
	#endregion

	#region Set the type
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
	#endregion
	
	#region Detect valid sprites
	var angle = ["Right", "Up", "Left", "Down"];
	for (var i = 0; i < array_length(angle); i++) {
		if (object_index == asset_get_index($"objSpike{angle[i]}")) {
			spike_spr = check_apply_asset($"sprSpike{angle[i]}{type}", $"sprSpike{angle[i]}");
		} else if (object_index == asset_get_index($"objMiniSpike{angle[i]}")) {
			if (asset_get_index($"sprMiniSpike{angle[i]}{type}") != -1) {
				spike_spr = asset_get_index($"sprMiniSpike{angle[i]}{type}");
			} else {
				spike_spr = check_apply_asset($"sprSpike{angle[i]}{type}", $"sprSpike{angle[i]}");
			}
		}
	}
		
	var combo = ["DiamondVertical", "DiamondHorizontal", "Shuriken", "Block", "Rotate", "Extend"];
	for (var i = 0; i < array_length(combo); i++) {
		if (object_index == asset_get_index($"objSpike{combo[i]}")) {
			spike_spr = check_apply_asset($"sprSpike{type}", sprSpike);
		}
	}
	
	var spike = {
		sprite: spike_spr,
		spd: spike_speed,
		image: spike_image
	};

	if (me) {
		sprite_index = spike.sprite;
		image_speed = spike.spd;
		image_index = spike.image;
	}
	#endregion

	return spike;
}

function fruit_sprite(me = true) {
	#region Initialize variables
	var type = "";

	var fruit_alt = sprCherry;
	var fruit_speed = 1;
	var fruit_image = 0;
	#endregion
	
	#region Set the type
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
	#endregion
	
	#region Detect valid sprite
	var fruit = {
		sprite: check_apply_asset($"sprCherry{type}", fruit_alt),
		spd: fruit_speed,
		image: fruit_image
	}
	
	if (me) {
		sprite_index = fruit.sprite;
		image_speed = fruit.spd;
		image_index = fruit.image;
	}
	#endregion
	
	return fruit;
}
#endregion