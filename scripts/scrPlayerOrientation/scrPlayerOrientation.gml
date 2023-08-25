#macro X p_x()
#macro Y p_y()
#macro Hspd p_hspd()
#macro Vspd p_vspd()

function p_x(val = null) {
    if (!instance_exists(objPlayer)) { exit; }
    
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

function p_y(val = null) {
    if (!instance_exists(objPlayer)) { exit; }
    
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

function p_hspd(val = null) {
    if (!instance_exists(objPlayer)) { 
        return 0;
        exit; 
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

function p_vspd(val = null) {
    if (!instance_exists(objPlayer)) { 
        return 0;
        exit; 
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

function p_instance_place(xx, yy, obj) {
    if (abs(global.grav) == 1) {
        return instance_place_check(x + xx, y + yy, obj, tangible_collision);
    } else {
        return instance_place_check(x + yy, y + xx, obj, tangible_collision);
    }
}