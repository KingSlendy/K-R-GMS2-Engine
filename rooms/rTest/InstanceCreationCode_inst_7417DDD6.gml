make_triggereable([
	new TriggerKey("test1", {
		x: new TriggerAttribute(self.x + 32, 3)
	}, trigger_loop, -1)
]);