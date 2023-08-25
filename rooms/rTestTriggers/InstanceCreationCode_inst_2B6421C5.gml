field = function() {
	add_trigger_key("trg3", {
		y: new TriggerVariable(self.y + 96, 2, attribute_loop_reverse)
	});
	
	add_trigger_key("trg4", {
		x: new TriggerVariable(self.x - 32, 2, attribute_loop_reverse)
	});
}