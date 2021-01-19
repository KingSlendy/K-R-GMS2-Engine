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

#region Other
function camera_properties(num) {
	var cam = view_camera[num];
	
	return {
		view_cam: cam,
		view_x: camera_get_view_x(cam),
		view_y: camera_get_view_y(cam),
		view_w: camera_get_view_width(cam),
		view_h: camera_get_view_height(cam)
	};
}


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

function map(value, from1, to1, from2, to2) {
	return (value - from1) / (to1 - from1) * (to2 - from2) + from2;
}

function get_frames(seconds) {
	return game_get_speed(gamespeed_fps) * seconds;
}

function print(str) {
	show_debug_message(str);
}
#endregion