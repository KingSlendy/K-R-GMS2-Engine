if (instance_exists(objPlayer)) {
	depth = objPlayer.depth - 1;
	x = objPlayer.x;
	y = objPlayer.y;
	image_xscale = objPlayer.xscale;
	image_yscale = global.grav;
} else {
	instance_destroy();
}