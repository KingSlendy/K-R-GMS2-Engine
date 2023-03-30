field = function() {
	make_triggerable([
		new TriggerKey("trg3", {
			y: new TriggerVariable(self.y + 96, 2, attribute_loop_reverse)
		}),
		
		new TriggerKey("trg4", {
			x: new TriggerVariable(self.x - 32, 2, attribute_loop_reverse)
		})
	])
}