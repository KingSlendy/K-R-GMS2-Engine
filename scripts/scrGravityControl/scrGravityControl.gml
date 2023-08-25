function p_x() {
	if (abs(global.grav) == 1) {
		return x;
	} else if (abs(global.grav) == 2) {
		return y;
	}
}

function p_y() {
	if (abs(global.grav) == 1) {
		return y;
	} else if (abs(global.grav) == 2) {
		return x;
	}
}

function p_hspd() {
	if (abs(global.grav) == 1) {
		return hspd;
	} else if (abs(global.grav) == 2) {
		return vspd;
	}
}

function p_vspd() {
	if (abs(global.grav) == 1) {
		return vspd;
	} else if (abs(global.grav) == 2) {
		return hspd;
	}
}