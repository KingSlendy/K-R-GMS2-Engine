if (!instance_exists(objPlayer)) {
	instance_create_layer(x + 17, y + 23, layer, objPlayer);
	instance_destroy();
}