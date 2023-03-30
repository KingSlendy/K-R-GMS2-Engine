var trigger_active_ids_size = ds_list_size(trigger_active_ids);

for (var i = 0; i < trigger_active_ids_size; i++) {
	with (trigger_active_ids[| i]) {
		var key_length = array_length(trigger_keys);
	
		for (var j = 0; j < key_length; j++) {
			var trigger_key = trigger_keys[j];
			var index = ds_list_find_index(other.trigger_active_keys, trigger_key.key);
		
			if (index == -1) {
				continue;
			}
		
			var attribute_keys = variable_struct_get_names(trigger_key.attributes);
			var attribute_keys_length = array_length(attribute_keys);
		
			for (var k = 0; k < attribute_keys_length; k++) {
				var attribute_key = attribute_keys[k];
				var attribute = trigger_key.attributes[$ attribute_key];
				
				if (attribute.completed) {
					continue;
				}
				
				if (is_instanceof(attribute, TriggerEvent)) {
					attribute.callback();
					attribute.decrease();
					continue;
				}
				
				if (!attribute.callback()) {
					continue;
				}
				
				other.trigger_types[$ attribute.type](id, attribute, attribute_key);
			}
		}
	}
}