//hspeed = 2;
visible = true;
make_triggerable([
	new TriggerKey("test1auto", {
		x: new TriggerVariable(self.x + 96, 2, attribute_loop_reverse)
	})
]);