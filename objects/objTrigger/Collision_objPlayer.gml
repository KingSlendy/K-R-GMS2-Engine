if (!triggered) {
	objTrigger.trigger = trigger; //Sets every trigger to this number
	
	//Activates every triggereable object
	with (objTriggereable) {
		trigger_activate();
	}
	
	triggered = true;
}