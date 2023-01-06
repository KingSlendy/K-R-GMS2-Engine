field = function() {
	if (!object_is_ancestor(object_index, objPlayerKiller)) {
		return;
	}
	
	depth = layer_get_depth("Tiles") + 1;
	
	make_triggerable([
		new TriggerKey("trg5", {
			y: new TriggerAttribute(self.y + 32, 0.5, attribute_loop_reverse)
		})
	]);
}