/*
This object helps to apply a certain trigger function to a bunch of objects at once.
It applies the 'field' function variable to all the objects that this trigger field collides with.
*/

try {
	if (apply_layer == "") {
		apply_layer = layer_get_name(layer);
	}
} catch (_) {
	apply_layer = null;
}

field = null;