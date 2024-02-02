if (Vspd * sign(global.grav) > 0) {
    other.water_mod.platform = 1;
    other.grav_amount = 0;
	p_vspd(0);
}