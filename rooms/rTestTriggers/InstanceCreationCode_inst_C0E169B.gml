field = function() {
	make_triggerable([
		new TriggerKey("trg1", {
			y: new TriggerAttribute(self.y - 32, 3, attribute_loop_reverse)
		})
	]);
}