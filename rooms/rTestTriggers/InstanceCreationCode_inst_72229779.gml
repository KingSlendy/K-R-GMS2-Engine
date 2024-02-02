add_trigger_key("trg2", {
	x: new TriggerVariable(self.x - 32, 1, attribute_loop_reverse)
});

add_trigger_key("trg3", {
	image_angle: new TriggerVariable(360, 1, attribute_loop)
});

add_trigger_key("trg4", {
	image_xscale: new TriggerVariable(3, 0.125, attribute_loop_reverse)
});

add_trigger_key("trg5", {
	image_alpha: new TriggerVariable(random(1), 1, attribute_loop_reverse)
});