function tangible_collision(obj) {
	return (obj.image_alpha == 1);
}

function dynamic_collision(setup = false, func = null, arg = null) {
	if (setup) {
	    xold = x;
	    yold = y;
	} else {
	    //Split these into two with blocks so a user event 1 runs only after every single block's user event 0
	    with (objBlockDynamic) {
	        inst = other;
	        event_user(0);
	    }
		
	    with (objBlockDynamic) {
	        event_user(1);
	    }

	    if (instance_place_check(x, y, objBlock, tangible_collision) != null && func != null) {
			func(arg);
	    }
    
	    //Set variables for next frame
	    xold = x;
	    yold = y;
	}
}

function instance_place_check(x, y, obj, func = function(obj) { return true; } ) {
	var list = ds_list_create();
	var count = instance_place_list(x, y, obj, list, false);
	var found = null;

	for (var i = 0; i < count; i++) {
	    var current = list[| i];

	    if (current == noone || !func(current)) {
	        continue;
	    }

	    found = current;
	    break;
	}

	ds_list_destroy(list);
	return found;
}

function move_bounce() {
	//Simple block bounce that will preserve height
	
	//Detect horizontal collision
	if (instance_place_check(x + hspeed, y, objBlock, tangible_collision) != null) {
		x -= hspeed;
	    hspeed *= -1;
	} 
	
	//Detect vertical collision
	if (instance_place_check(x, y + vspeed, objBlock, tangible_collision) != null) {
		y -= vspeed;
		vspeed *= -1;
	}
	
	//Detect diagonal collision
	if (instance_place_check(x + hspeed, y + vspeed, objBlock, tangible_collision) != null) {
		x -= hspeed;
		hspeed *= -1;
			
		y -= vspeed;
		vspeed *= -1;
	}
}