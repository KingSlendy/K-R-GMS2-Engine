make_triggereable([
	new TriggerKey("trigger1", {
		image_xscale: new TriggerAttribute(5, 0.1),
		image_yscale: new TriggerAttribute(5, 0.1),
		image_alpha: new TriggerAttribute(0.5, 0.05)
	}, trigger_loop_reverse, 5)
]);