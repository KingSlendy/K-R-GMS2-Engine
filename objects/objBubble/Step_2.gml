image_xscale = scale;
image_yscale = scale;

if (active) {
	if (instance_exists(objPlayer) && !pop) {
	    objPlayer.x = x;
	    objPlayer.y = y;
	    depth = objPlayer.depth - 1;
	} else {
	    scale = approach(scale, 2, 0.2);
	    if (scale == 2) {
	    	audio_play_sound(sndBubblePop, 0, false);
	        instance_destroy();
	    }
	}
	
	#region Collision with an object that pops the bubble
	if (object != noone) {
		var poking = collision_circle(round(x), round(y), 32, object, true, 0);
	
		if ((poking != noone && poking.image_alpha == 1 && poking.visible) && !pop) {
			pop = true;
		}
	}
	#endregion
}