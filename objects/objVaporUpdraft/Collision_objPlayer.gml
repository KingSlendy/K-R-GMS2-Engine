if (!object_index.drafted) {
    if (VSPD * sign(global.grav) >= -6 && VSPD * sign(global.grav) <= -5.2) {
        p_vspd(-6 * sign(global.grav));
	} else if (VSPD * sign(global.grav) > -5.2) {
        p_vspd(VSPD - 0.8 * sign(global.grav));
	}

    object_index.drafted = true;
}