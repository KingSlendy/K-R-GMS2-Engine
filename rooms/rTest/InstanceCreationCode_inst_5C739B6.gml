make_triggereable([
	new TriggerKey("test0", {
		image_xscale: new TriggerAttribute(5, 1),
		vspeed: new TriggerAttribute(1, 0.1)
	}, trigger_overtime),
	
	new TriggerKey("test1", {
		image_yscale: new TriggerAttribute(5, 1),
		hspeed: new TriggerAttribute(-3, 0.1)
	}, trigger_overtime)
]);