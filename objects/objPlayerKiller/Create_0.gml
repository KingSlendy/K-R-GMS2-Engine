#region Spike Sprites
if (object_is_ancestor(object_index, objSpikeController)) {
	spikedirs = [
		//regular spikes
		"Right",
		"Up",
		"Left",
		"Down",
	
		//combo spikes
		"DiamondVertical",
		"DiamondHorizontal",
		"Shuriken",
		"Block",
	
		//other spikes
		"Rotate",
	];

	for (var i = 0; i < array_length(spikedirs); i++) {
	    if (object_index == asset_get_index("objSpike" + spikedirs[i]) || object_index == asset_get_index("objMiniSpike" + spikedirs[i])) {
	        mask_index = sprite_index;
			spike_sprite();
		}
	}
}
#endregion

#region Fruit Sprites
if (object_index == objCherry || object_is_ancestor(object_index, objCherry)) {
    fruit_sprite();
}
#endregion