if (!global.use_bow) {
	instance_destroy();
	exit;
}

event_perform(ev_step, ev_step_end);