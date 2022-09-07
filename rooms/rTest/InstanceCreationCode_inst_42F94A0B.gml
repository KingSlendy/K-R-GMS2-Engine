make_triggereable([
	new TriggerKey("test0", {
		y: new TriggerAttribute(self.y + 32, 5)
	}, trigger_loop)
]);