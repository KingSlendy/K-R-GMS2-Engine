visible = true;

add_trigger_key("test1auto", {
	y: new TriggerVariable(self.y - 96, 2, attribute_loop_reverse)
});