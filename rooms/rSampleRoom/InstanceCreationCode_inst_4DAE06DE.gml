//vspeed = 2;
visible = true;
make_triggerable([
	new TriggerKey("test1auto", {
		y: new TriggerAttribute(self.y + 96, 2, attribute_loop_reverse)
	})
]);