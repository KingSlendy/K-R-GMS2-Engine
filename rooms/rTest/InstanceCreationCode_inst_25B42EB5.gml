make_triggereable([
	new TriggerKey("trigger1", {
		image_xscale: new TriggerAttribute(5, 0.5),
		image_yscale: new TriggerAttribute(5, 0.5)
	}, trigger_overtime),
	
	new TriggerKey("trigger2", {
		y: new TriggerAttribute(self.y + 96, 3)
	}, trigger_overtime)
])