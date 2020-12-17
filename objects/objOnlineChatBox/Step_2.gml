var __ONLINE_f = __ONLINE_follower;

if (instance_exists(__ONLINE_f)) {
	x = __ONLINE_f.x;
	y = __ONLINE_f.y;
} else {
	instance_destroy();
	exit;
}

if(__ONLINE_fade){
	__ONLINE_fadeAlpha -= 0.02;
	
	if (__ONLINE_fadeAlpha <= 0) {
		instance_destroy();
		exit;
	}
}

__ONLINE_alpha = 1;

if (__ONLINE_follower != objPlayer) {
	visible = __ONLINE_follower.visible;
	var __ONLINE_p = objPlayer;

	if (instance_exists(__ONLINE_p)) {
		var __ONLINE_dist = distance_to_object(__ONLINE_p);
		__ONLINE_alpha = __ONLINE_dist / 100;
	}
}

__ONLINE_t -= 1;

if (__ONLINE_t < 0) {
	__ONLINE_fade = true;
}

// Destroy all other chatboxes of the same player
if (!__ONLINE_hasDestroyed) {
	var __ONLINE_found = false;
	var __ONLINE_oChatbox = 0;
	
	for (var __ONLINE_i = 0; __ONLINE_i < (instance_number(object_index) && !__ONLINE_found); __ONLINE_i++) {
		__ONLINE_oChatbox = instance_find(object_index, __ONLINE_i);
		
		if (__ONLINE_oChatbox.__ONLINE_follower == __ONLINE_follower && __ONLINE_oChatbox.id != id) {
			__ONLINE_found = true;
		}
	}
	
	if (__ONLINE_found) {
		instance_destroy(__ONLINE_oChatbox);
	}
	
	__ONLINE_hasDestroyed = true;
}
