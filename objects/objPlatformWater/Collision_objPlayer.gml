if (other.vspd * global.grav > 0) {
    other.water_mod.platform = 1;
    other.grav_amount = 0;
	other.vspd = 0;
}