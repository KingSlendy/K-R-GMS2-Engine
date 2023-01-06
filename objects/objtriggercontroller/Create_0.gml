trigger_active_keys = ds_list_create();
trigger_active_ids = ds_list_create();
trigger_types = {};
var tt = trigger_types;

tt[$ attribute_normal] = function(id, attribute, key) {
	var value = approach(variable_instance_get(id, key), attribute.target, attribute.spd);
	
	if (value == attribute.target) {
		attribute.decrease();
	}
	
	variable_instance_set(id, key, value);
}

tt[$ attribute_loop] = function(id, attribute, key) {
	var value = approach(variable_instance_get(id, key), attribute.target, attribute.spd);
	
	if (value == attribute.target) {
		value = attribute.start;
		attribute.decrease();
	}
	
	variable_instance_set(id, key, value);
}

tt[$ attribute_loop_reverse]  = function(id, attribute, key) {
	var value = approach(variable_instance_get(id, key), attribute.target, attribute.spd);
	
	if (value == attribute.target) {
		var temp = attribute.start;
		attribute.start = attribute.target;
		attribute.target = temp;
		attribute.decrease();
	}
	
	variable_instance_set(id, key, value);
}