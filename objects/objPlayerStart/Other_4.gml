if (!instance_exists(objPlayer)) {
	instance_create_layer(x + 17, y + 23, "Instances", objPlayer);
	instance_destroy();
}