if (!object_index.drafted) {
    if (other.vspd * global.grav >= -6 && other.vspd * global.grav <= -5.2) {
        other.vspd = -6 * global.grav;
	} else if (other.vspd * global.grav > -5.2) {
        other.vspd -= 0.8 * global.grav;
	}

    object_index.drafted = true;
}