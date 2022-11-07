make_triggerable([
	new TriggerKey("trgLoop1", {
		x: new TriggerAttribute(self.x + 64, 3, attribute_loop_reverse)
	})
]);