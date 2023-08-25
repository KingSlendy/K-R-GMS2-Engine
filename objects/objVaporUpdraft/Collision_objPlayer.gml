if (!object_index.drafted) {
    if (Vspd * sign(global.grav) >= -6 && Vspd * sign(global.grav) <= -5.2) {
        p_vspd(-6 * sign(global.grav));
	} else if (Vspd * sign(global.grav) > -5.2) {
        p_vspd(Vspd - 0.8 * sign(global.grav));
	}

    object_index.drafted = true;
}