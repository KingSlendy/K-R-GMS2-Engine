triggered = false;

function trigger_activate() {
	if (instance_exists(objTrigger)) {
		if (!triggered && objTrigger.triggered == trigger) {
			hspeed = hspd;
			vspeed = vspd;
			triggered = true;
		}
	}
}