#macro attribute_normal 0
#macro attribute_loop 1
#macro attribute_loop_reverse 2

function TriggerKey(key, attributes) constructor {
	self.key = key;
	self.attributes = attributes;
	
	var names = variable_struct_get_names(self.attributes);
	var length = array_length(names);
	
	for (var i = 0; i < length; i++) {
		var name = names[i];
		var attribute = self.attributes[$ name];
		
		if (instanceof(attribute) != "TriggerAttribute") {
			self.attributes[$ name] = new TriggerAttribute(attribute);
			attribute = self.attributes[$ name];
		}
		
		attribute.start = variable_instance_get(other.id, name);
	}
}

function TriggerAttribute(target, spd = abs(target), type = attribute_normal, times = -1, func = function() { return true; }) constructor {
	self.target = target;
	self.spd = spd;
	self.type = type;
	self.times = times;
	self.func = func;
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

function make_triggerable(trigger_keys) {
	self.trigger_keys = trigger_keys;
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

function deactivate_trigger(key) {
	with (all) {
		if (!variable_instance_exists(id, "trigger_keys")) {
			continue;
		}
		
		var trigger_keys_length = array_length(trigger_keys);
		var trigger_keys_any = false;
		var trigger_key = null;
		
		for (var i = 0; i < trigger_keys_length; i++) {
			trigger_key = trigger_keys[i];
			
			if (trigger_key.key == key) {
				trigger_keys_any = true;
				break;
			}
		}
		
		if (!trigger_keys_any) {
			continue;
		}
		
		var attribute_keys = variable_struct_get_names(trigger_key.attributes);
		var attribute_keys_length = array_length(attribute_keys);
		
		for (var k = 0; k < attribute_keys_length; k++) {
			var attribute_key = attribute_keys[k];
			var attribute = trigger_key.attributes[$ attribute_key];
			attribute.completed = false;
		}
	}
	
    ds_list_delete(objTriggerController.trigger_active_keys, ds_list_find_index(objTriggerController.trigger_active_keys, key));
}

function toggle_trigger(key, state) {
    var set = (state) ? activate_trigger : deactivate_trigger;
    set(key);
}

function reactivate_trigger(key) {
	deactivate_trigger(key);
	activate_trigger(key);
}

function is_active_trigger(key) {
	return (ds_list_find_index(objTriggerController.trigger_active_keys, key) != -1);
}