#region End Step collision with block
///Resolve collisions between step and now, collide with dynamic blocks
if (p_instance_place(0, 0, objBlock) != null) {
    var dir_x = sign(X - xsafe);
    var dir_y = sign(Y - ysafe);
    var epsilon = 0.001; //Appease the floating point gods
    
    //If something moved the player into a block since Step, move back towards where we were until we're out of a block.
	while (p_instance_place(0, 0, objBlock) == null) {
        if (dir_x * (X - xsafe) >= epsilon) {
            p_x(X - sign(X - xsafe) * min(abs(X - xsafe), 1));
        } else if (dir_y * (Y - ysafe) >= epsilon) {
            p_y(Y - sign(Y - ysafe) * min(abs(Y - ysafe), 1));
        } else {
			break;
		}
    }
}

dynamic_collision(false);
#endregion

#region Old collision with platform
if (!global.forms.lunarkid) {
	var platform = p_instance_place(0, 0, objPlatform);

	if (platform != null && platform.visible) {
		if (platform.snap > 0 && ((sign(global.grav) == 1 && Y - Vspd / 2 <= platform.bbox_top) || (sign(global.grav) == -1 && Y - Vspd / 2 >= platform.bbox_bottom))) {
			p_y((sign(global.grav == 1)) ? platform.bbox_top - 9 : platform.bbox_bottom + 8);
			p_vspd(platform.vspeed);
			
			if (platform.object_index != objDisappearPlatform) {
				on_platform = true;
			}
			
			reset_jumps();
		}
		
		if (platform.object_index == objDisappearPlatform) {
			platform.visible = false;
		}
	}
}
#endregion
 
#region Collision with killers
var killer = p_instance_place(0, 0, objPlayerKiller);

if (killer != null && killer.visible) {
	kill_player();
}

hit = approach(hit, 0, 1);
image_alpha = (hit > 0) ? 0.7 : 1;
#endregion

#region Touches screen border
if (global.outside_kills && outside_room()) {
	kill_player();
}
#endregion

set_mask();