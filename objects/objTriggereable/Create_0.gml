event_inherited();

function trigger_activate() {
	if (instance_exists(objTrigger)) {
		if (!triggered && objTrigger.trigger == trigger) {
			hspeed = hspd;
			vspeed = vspd;
			triggered = true;
		}
	}
}