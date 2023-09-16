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
	if (object != null) {
		var popper = collision_circle(round(x), round(y), 32, object, true, 0);
	
		if ((popper != noone && popper.image_alpha == 1 && popper.visible) && !pop) {
			pop = true;
		}
	}
	#endregion
}