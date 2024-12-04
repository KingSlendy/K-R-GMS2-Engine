///Script that controls the relative physics of the player

//THIS SCRIPT ALLOWS SIDEWAYS GRAVITY TO FUNCTION

//Use the macros directly for GETTING the player's movement variables
//Use the functions directly for SETTING the player's movement variables

#macro X p_x()
#macro Y p_y()
#macro HSPD p_hspd()
#macro VSPD p_vspd()
#macro BBOX_LEFT get_bbox_left()
#macro BBOX_RIGHT get_bbox_right()
#macro BBOX_TOP get_bbox_top()
#macro BBOX_BOTTOM get_bbox_bottom()

function p_x(val = null) { //Gets OR Sets the player's relative X position
    if (!instance_exists(objPlayer)) { 
    	return 0;
    }
    
    player = objPlayer.id;
    _x = player.x;
    
	if (abs(global.grav) == 1) {
		_x = player.x;
		if (val != null) {
		    _x = val;
		    player.x = _x;
		}
	} else if (abs(global.grav) == 2) {
		_x = player.y;
		if (val != null) {
		    _x = val;
		    player.y = _x;
		}
	}
	
	return _x;
}

function p_y(val = null) { // Gets OR Sets the player's relative Y position
    if (!instance_exists(objPlayer)) { 
    	return 0;
    }
    
    player = objPlayer.id;
    _y = player.y;
    
	if (abs(global.grav) == 1) {
		_y = player.y;
		if (val != null) {
		    _y = val;
		    player.y = _y;
		}
	} else if (abs(global.grav) == 2) {
		_y = player.x;
		if (val != null) {
		    _y = val;
		    player.x = _y;
		}
	}
	
	return _y;
}

function p_hspd(val = null) { //Gets OR Sets the player's relative hspd
    if (!instance_exists(objPlayer)) { 
        return 0;
    }
    
    player = objPlayer.id;
    _hspd = null;
    
	if (abs(global.grav) == 1) {
		if (val != null) { 
		    player.hspd = val;
		}
		_hspd = player.hspd;
	} else if (abs(global.grav) == 2) {
		if (val != null) {
		    player.vspd = val;
		}
		_hspd = player.vspd;
	}
	
	return _hspd;
}

function p_vspd(val = null) { //Gets OR Sets the player's relative vspd
    if (!instance_exists(objPlayer)) { 
        return 0;
    }
    
    player = objPlayer.id;
    _vspd = null;
    
	if (abs(global.grav) == 1) {
		if (val != null) { 
		    player.vspd = val;
		}
		_vspd = player.vspd;
	} else if (abs(global.grav) == 2) {
		if (val != null) {
		    player.hspd = val;
		}
		_vspd = player.hspd;
	}
	
	return _vspd;
}

function p_instance_place(xx, yy, obj, func = tangible_collision) { //Sets how the player will collide with "obj" relative to the current gravity
    if (abs(global.grav) == 1) {
        return instance_place_check(x + xx, y + yy, obj, func);
    } else if (abs(global.grav) == 2) {
        return instance_place_check(x + yy, y + xx, obj, func);
    }
}

function p_collision_point(xx, yy, obj, prec, notme, func = tangible_collision) { //Sets how the player will collide with "obj" relative to the current gravity
    if (abs(global.grav) == 1) {
        return collision_point_check(xx, yy, obj, prec, notme, func);
    } else if (abs(global.grav) == 2) {
        return collision_point_check(yy, xx, obj, prec, notme, func);
    }
}

function p_collision_line(xx1, yy1, xx2, yy2, obj, prec, notme, func = tangible_collision) { //Sets how the player will collide with "obj" relative to the current gravity
    if (abs(global.grav) == 1) {
        return collision_line_check(xx1, yy1, xx2, yy2, obj, prec, notme, func);
    } else if (abs(global.grav) == 2) {
        return collision_line_check(yy1, xx1, yy2, xx2, obj, prec, notme, func);
    }
}

function get_bbox_left() {
	if (abs(global.grav) == 1) {
		return (sign(global.grav) == 1) ? bbox_left : bbox_right;
	} else if (abs(global.grav) == 2) {
		return (sign(global.grav) == 1) ? bbox_bottom : bbox_top;
	}
}

function get_bbox_right() {
	if (abs(global.grav) == 1) {
		return (sign(global.grav) == 1) ? bbox_right : bbox_left;
	} else if (abs(global.grav) == 2) {
		return (sign(global.grav) == 1) ? bbox_top : bbox_bottom;
	}
}

function get_bbox_top() {
	if (abs(global.grav) == 1) {
		return (sign(global.grav) == 1) ? bbox_top : bbox_bottom;
	} else if (abs(global.grav) == 2) {
		return (sign(global.grav) == 1) ? bbox_left : bbox_right;
	}
}

function get_bbox_bottom() {
	if (abs(global.grav) == 1) {
		return (sign(global.grav) == 1) ? bbox_bottom : bbox_top;
	} else if (abs(global.grav) == 2) {
		return (sign(global.grav) == 1) ? bbox_right : bbox_left;
	}
}