if (!instance_exists(objPlayer)) {
	var pos = [17, 23];
	if (global.forms.dotkid) {
		pos = [16, 31];
	} else if (global.forms.lunarkid) {
		pos = [17, 17];
	} else if (global.forms.linekid) {
		pos = [16, 19];
	}

	instance_create_layer(x + pos[0], y + pos[1], layer, objPlayer);
	instance_destroy();
}