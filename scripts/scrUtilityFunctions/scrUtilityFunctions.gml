#region Arrays
function array_count(array, check) {
	var count = 0;
	var length = array_length(array);

	for (var i = 0; i < length; i++) {
	    if (array[i] == check) {
	        count++;
	    }
	}

	return count;
}

function array_contains(array, check) {
	var length = array_length(array);
	
	for (var i = 0; i < length; i++) {
	    if (array[i] == check) {
	        return true;
	    }
	}

	return false;
}

function array_shuffle(array) {
	var length = array_length(array);

	for (var i = 0; i < length; i++) {
	    var temp = array[i];
	    var rnd = irandom(length - 1);
	    array[i] = array[rnd];
	    array[rnd] = temp;
	}

	return array;
}

function array_pick(array) {
	return array[irandom(array_length(array) - 1)];
}
#endregion

#region Strings
function string_interp(str) {
	for (var i = 0; i < argument_count - 1; i++) {
	    str = string_replace(str, "{" + string(i) + "}", string(argument[i + 1]));
	}

	return str;
}

function string_join(array) {
	var joined = "";
	var length = array_length(array);

	for (var i = 0; i < length; i++) {
	    if (i < length - 1) {
	        joined += string(array[i]) + argument[1];
	    } else {
	        joined += string(array[i]);
	    }
	}

	return joined;
}

function string_split(str, substr) {
	var splitted = [];
	var sub_count = string_count(substr, str);
	var now_index = 1;
	var count_index = 1;
	var length = string_length(str);
	var sub_length = string_length(substr);

	if (sub_count == 0) {
	    return str;
	}

	if (substr == "") {
	    for (var i = 0; i < length; i++) {
	        splitted[i] = string_char_at(str, i + 1);
	    }
    
	    return str;
	}

	for (var i = 0; i <= sub_count; i++) {
	    if (i < sub_count) {
	        var rem_index = now_index;    
        
	        while (string_copy(str, now_index, sub_length) != substr) {
	            now_index++;
	            count_index++;
	        }
        
	        splitted[i] = string_copy(str, rem_index, count_index - 1);
	        now_index += sub_length;
	        count_index = 1;
	    } else {
	        splitted[i] = string_copy(str, now_index, length - now_index + 1);
	    }
	}

	return splitted;
}
#endregion

#region Drawing
function draw_text_outline(x, y, text, border_color) {
	var color = draw_get_color();
	draw_set_color(border_color);

	for (var i = -1; i < 2; i++) {
	    for (var j = -1; j < 2; j++) {
	        draw_text(x + j, y + i, text);
	    }
	}

	draw_set_colour(color);
	draw_text(x, y, text);
}

function draw_sprite_fog(sprite, subimg, xx, yy, xscale, yscale, rot, col, alpha, fog_color) {
	gpu_set_fog(1,fog_color,0,0);
	draw_sprite_ext(sprite, subimg, xx, yy, xscale, yscale, rot, col, alpha);
	gpu_set_fog(0,0,0,0);
}
#endregion

#region Collision
function dynamic_collision(setup = false) {
	if (argument_count >= 2) {
		var script = argument[1];
	} //Script to run when the instance is crushed at the end of collision
	if (argument_count >= 3) {
		var arg = argument[2]; 
	} //Argument for crush script

	if (setup) {
	    xold = x;
	    yold = y;
	} else {
	    //Split these into two with blocks so a user event 1 runs only after every single block's user event 0
	    with (objBlockDynamic) {
	        inst = other;
	        event_user(0);
	    }
	    with (objBlockDynamic) {
	        event_user(1);
	    }
    
		var tangible = function(obj) { return (obj.image_alpha == 1); }
	    //Check if crushed
		//if (!place_free(x, y) && argument_count >= 2) {
	    if (instance_place_check(x, y, objBlock, tangible) != noone && argument_count >= 2) {
	        if (argument_count <= 2) {
				script_execute(script);
			} else {
				script_execute(script, arg);
			}
	    }
    
	    //Set variables for next frame
	    xold = x;
	    yold = y;
	}
}

function instance_place_check(x, y, obj, func = function(obj) { return true; } ) {
	var list = ds_list_create();
	var count = instance_place_list(x, y, obj, list, false);
	var found = noone;

	for (var i = 0; i < count; i++) {
	    var current = list[| i];

	    if (current == noone || !func(current)) {
	        continue;
	    }

	    found = current;
	    break;
	}

	ds_list_destroy(list);
	return found;
}

function move_bounce() {
	var tangible = function(obj) { return (obj.image_alpha == 1); }
	
	//simple block bounce that will preserve height
	if (instance_place_check(x + hspeed, y, objBlock, tangible) != noone) { //Detect horizontal collision
		x -= hspeed;
	    hspeed *= -1;
	} 
	if (instance_place_check(x, y + vspeed, objBlock, tangible) != noone) { //Detect vertical collision
		y -= vspeed;
		vspeed *= -1;
	}
	if (instance_place_check(x + hspeed, y + vspeed, objBlock, tangible) != noone) { //Detect diagonal collision
		x -= hspeed;
		hspeed *= -1;
			
		y -= vspeed;
		vspeed *= -1;
	}
}
#endregion

#region Other
function camera_properties(num) {
	var cam = view_camera[num];
	
	return {
		view_cam: cam,
		view_x: camera_get_view_x(cam),
		view_y: camera_get_view_y(cam),
		view_w: camera_get_view_width(cam),
		view_h: camera_get_view_height(cam),
		view_xw: camera_get_view_x(cam) + camera_get_view_width(cam),
		view_yh: camera_get_view_y(cam) + camera_get_view_height(cam),
		view_angle: camera_get_view_angle(cam),
	};
}

function map(value, from1, to1, from2, to2) {
	return (value - from1) / (to1 - from1) * (to2 - from2) + from2;
}

function approach(val1, val2, amount) {
	if (val1 == val2) {
		return val1;
	}
	
	if (val1 < val2) {
		return min(val1 + amount, val2);
	} else {
		return max(val1 - amount, val2);
	}
}

function struct_all(struct) {
    var names = variable_struct_get_names(struct);

    for (var i = 0; i < array_length(names); i++) {
        if (!struct[$ names[i]]) {
            return false;
        }
    }

    return true;
}

function struct_set_all(struct, value) {
    var names = variable_struct_get_names(struct);
    
    for (var i = 0; i < array_length(names); i++) {
        struct[$ names[i]] = value;
    }
}

function seconds_to_frames(seconds) {
	return game_get_speed(gamespeed_fps) * seconds;
}

function print(str) {
	show_debug_message(str);
}
#endregion