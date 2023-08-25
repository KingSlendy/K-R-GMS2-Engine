field = function() {
	add_trigger_key("trg5", {
		y: new TriggerVariable(self.y + 32, 0.5, attribute_loop_reverse)
	});
}