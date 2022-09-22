if (global.grav == -1) {
    if (other.vspd < -0.5) {
        other.vspd = -0.5;
	}
} else if (other.vspd > 5) {
    other.vspd = 5;
} else {
    other.vspd += 0.15;
}

/*if (global.grav == 1) {
    if (other.vspd > 0.5) {
        other.vspd = 0.5;
	}
} else if (other.vspd < -5) {
    other.vspd = -5;
} else {
    other.vspd -= 0.15;
}