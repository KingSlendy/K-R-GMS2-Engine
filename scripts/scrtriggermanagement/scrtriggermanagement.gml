#macro trigger_instant 0
#macro trigger_overtime 1
#macro trigger_reverse 2
#macro trigger_loop 3
#macro trigger_loop_reverse 4

function TriggerKey(key, attributes, type = trigger_instant, times = -1) constructor {
	self.key = key;
	self.attributes = attributes;
	self.type = type;
	self.times = times;
	
	var names = variable_struct_get_names(self.attributes);
	var length = array_length(names);
	
	for (var i = 0; i < length; i++) {
		var attribute = self.attributes[$ names[i]];
		attribute.start = variable_instance_get(other.id, names[i]);
		attribute.times = self.times;
	}
}

function TriggerAttribute(target, spd = abs(target)) constructor {
	self.target = target;
	self.spd = spd;
	self.reversed = false;
	self.completed = false;
	
	static decrease = function() {
		if (self.times <= 0) {
			return;
		}
		
		if (--self.times <= 0) {
			self.completed = true;
		}
	}
}

function make_triggereable(trigger_keys) {
	with (id) {
		self.trigger_keys = trigger_keys;
	}
}

function activate_trigger(key) {
	if (ds_list_find_index(objTriggerController.trigger_active_keys, key) != -1) {
		return;
	}
	
	ds_list_add(objTriggerController.trigger_active_keys, key);
	
	with (all) {
		if (!variable_instance_exists(id, "trigger_keys")) {
			continue;
		}
		
		var trigger_keys_length = array_length(trigger_keys);
		var trigger_keys_any = false;
		
		for (var i = 0; i < trigger_keys_length; i++) {
			if (trigger_keys[i].key == key) {
				trigger_keys_any = true;
				break;
			}
		}
		
		if (!trigger_keys_any) {
			continue;
		}
		
		if (ds_list_find_index(objTriggerController.trigger_active_ids, id) == -1) {
			ds_list_add(objTriggerController.trigger_active_ids, id);
		}
	}
}

function is_active_trigger(key) {
	return (ds_list_find_index(objTriggerController.trigger_active_keys, key) != -1);
}