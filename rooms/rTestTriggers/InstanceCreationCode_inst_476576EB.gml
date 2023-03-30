make_triggerable([
	new TriggerKey("trg4", {
		image_xscale: new TriggerVariable(2, 0.1,,, function() { return (self.image_yscale == 4); }),
		image_yscale: new TriggerVariable(4, 0.5)
	})
]);