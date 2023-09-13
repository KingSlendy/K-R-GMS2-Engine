#region Movement
if (active) {
    var dir_left = is_held(global.controls.left);
    var dir_right = is_held(global.controls.right);
    var dir_up = is_held(global.controls.up);
    var dir_down = is_held(global.controls.down);

	hspd = (hspd + (dir_right - dir_left) * 0.1);
	vspd = (vspd + (dir_down - dir_up) * 0.1);
	
    if (spd_get() > 0) {
        if (!dir_left || !dir_right || !dir_up || !dir_down) {
            spd_set(approach(spd_get(), 0, 0.05), spd_dir());
        }
    } else {
        spd_set(0);
    }
    
    if (instance_exists(objPlayer)) {
        with (objPlayer) {
        	hspd = 0;
        	vspd = 0;
            grav = 0;
            if (!global.forms.dotkid && !global.forms.lunarkid && !global.forms.linekid) {
                sprite_index = PLAYER_ACTIONS.FALL;
            }
        }
        mask_index = objPlayer.mask_index;
        image_index = objPlayer.image_index;
    }
}
#endregion

//Storing the previous x and y
xprevious = x;
yprevious = y;

//Moving the player manually
x += hspd;
y += vspd;

#region Collision with blocks
var block = instance_place_check(x, y, objBlock, tangible_collision);

if (block != null) {
	x = xprevious;
	y = yprevious;
	
	//Detect horizontal collision
	if (instance_place_check(x + hspd, y, objBlock, tangible_collision) != null) {
		while (instance_place_check(x + sign(hspd), y, objBlock, tangible_collision) == null) {
			x += sign(hspd);
		}
	
		hspd = 0;
	}

	//Detect vertical collision
	if (instance_place_check(x, y + vspd, objBlock, tangible_collision) != null) {
		while (instance_place_check(x, y + sign(vspd), objBlock, tangible_collision) == null) {
			y += sign(vspd);
		}
	
		vspd = 0;
	}

	//Detect diagonal collision
	if (instance_place_check(x + hspd, y + vspd, objBlock, tangible_collision) != null) {
		hspd = 0;
	}

	x += hspd;
	y += vspd;
}
#endregion