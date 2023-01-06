make_triggerable([
	new TriggerKey("trg1", {
		x: new TriggerAttribute(self.x + 32, 3),
		vspeed: new TriggerAttribute(-3,,,, function() {
			return (self.x == xstart + 32);
		}),
		
		image_xscale: new TriggerAttribute(3, 0.2,,, function() {
			return (place_meeting(x, y, objPlayerKiller));
		})
	}),
	
	new TriggerKey("trg2", {
		image_alpha: new TriggerAttribute(0, 0.05)
	})
]);