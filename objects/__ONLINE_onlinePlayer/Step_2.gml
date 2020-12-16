visible = (__ONLINE_oRoom == room);
image_alpha = __ONLINE_alpha;
var __ONLINE_p = objPlayer;

if (instance_exists(__ONLINE_p)){
	var __ONLINE_dist = distance_to_object(__ONLINE_p);
	image_alpha = min(__ONLINE_alpha, __ONLINE_dist / 100);
}