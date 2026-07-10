visible = true;

add_trigger_key("test1auto", {
	x: new TriggerVariable(self.x + 96, 2, attribute_loop_reverse)
});