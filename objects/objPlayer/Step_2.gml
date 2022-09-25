var tangible = function(obj) { return (obj.image_alpha == 1); }

#region Old collision with platform
if (!global.forms.lunarkid) {
	var platform = instance_place_check(x, y, objPlatform, tangible);

	if (platform != noone && platform.visible) {
		if (platform.snap > 0 && ((global.grav == 1 && y - vspd / 2 <= platform.bbox_top) || (global.grav == -1 && y - vspd / 2 >= platform.bbox_bottom))) {
			y = (global.grav == 1) ? platform.bbox_top - 9 : platform.bbox_bottom + 9;
			vspd = platform.vspeed;
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