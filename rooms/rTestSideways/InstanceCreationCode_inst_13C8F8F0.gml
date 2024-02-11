make_triggerable([
	new TriggerKey("trigger1", {
		image_xscale: new TriggerAttribute(5, 0.3),
		vspeed: new TriggerAttribute(12,,,, function() { return (image_xscale == 5); })
	})
]);