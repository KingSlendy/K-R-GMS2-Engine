var tangible = function(obj) { return (obj.image_alpha == 1); }

#region Old collision with platform
if (!global.forms.lunarkid) {
	var platform = instance_place_check(x, y, objPlatform, tangible);

	if (platform != noone && platform.visible && platform.snap > 0) {
		if (global.grav == 1) {  //normal
		    if (y - vspd / 2 <= platform.y) {
		        y = platform.y - 9;
		        vspd = platform.vspeed;
				if (!object_is_ancestor(platform, objDisappearPlatform)) {
					on_platform = true;
				}
		        reset_jumps();
		    }
		} else {   //flipped
		    if (y - vspd / 2 >= platform.y + platform.sprite_height - 1) {
		        y = platform.y + platform.sprite_height + 8;
		        vspd = platform.vspeed;
				if (!object_is_ancestor(platform, objDisappearPlatform)) {
					on_platform = true;
				}
		        reset_jumps();
		    }
		}
	}
}
#endregion

#region Collision with killers
var killer = instance_place(x, y, objPlayerKiller);

if (killer != noone && killer.visible) {
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