function package_nangextra(load_type = undefined) {
	if (load_type == undefined) { exit; }
	
	switch(load_type) {
		case "player prestep":
		frozen += (p_instance_place(0, 0, objAutoSpeedField) != null && Hspd != 0);
		break;

		case "player step":
		#region Gravity
		if (place_meeting(x, y, objZeroGravField)) {
			grav_amount = 0;
		}
		#endregion
		break;
	}
}