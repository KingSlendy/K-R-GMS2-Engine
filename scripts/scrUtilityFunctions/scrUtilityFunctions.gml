#region Arrays
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

#region Structs
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
#endregion

#region Physics
function pivot_pos_x(px, py, dir) {
	return lengthdir_x(px, dir) + lengthdir_x(py, dir - 90);
}

function pivot_pos_y(px, py, dir) {
	return lengthdir_y(px, dir) + lengthdir_y(py, dir - 90);
}

function spd_dir() {
    return point_direction(0, 0, hspd, vspd);
}

function spd_set(spd = spd_get(), dir = spd_dir()) {
    hspd = lengthdir_x(spd, dir);
    vspd = lengthdir_y(spd, dir);
}

function spd_get() {
    return point_distance(0, 0, hspd, vspd);
}

function change_angle() {
	image_angle = 90 * abs(global.grav) - (90 * sign(global.grav));
}

function mask_angle(object) {
	var dir = -1;
	if (!no_mask) {
		if (image_angle mod 360 == 90 || image_angle mod 360 == -270) {
			dir = sprSpikeUp;
		} else if (abs(image_angle) mod 360 == 180) {
			dir = sprSpikeLeft;
		} else if (image_angle mod 360 == 270 || image_angle mod 360 == -90) {
			dir = sprSpikeDown;	
		} else if (image_angle mod 360 == 0) {
			dir = sprSpikeRight;
		}
	}
	object.mask_index = dir;
}
#endregion

#region Other
function remap(value, from1, to1, from2, to2) {
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

function seconds_to_frames(seconds) {
	return game_get_speed(gamespeed_fps) * seconds;
}

function print(str) {
	show_debug_message(str);
}
#endregion