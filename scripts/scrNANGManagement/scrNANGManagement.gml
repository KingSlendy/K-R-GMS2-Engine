function package_nang(load_type = undefined) {
	if (load_type == undefined) { exit; }
	
	switch(load_type) {
		case "player prestep":
		frozen += (p_instance_place(0, 0, objAutoSpeedField) != null && Hspd != 0);
		break;
		
		case "player step": //Sets the kid's local speed based on what fields he's colliding with
		#region Speed
		if (place_meeting(x, y, objFastSpeedField)) {
			max_hspd = 6;
		} else if (place_meeting(x, y, objSlowSpeedField)) {
			max_hspd = 1;
		}
		#endregion
		
		#region Gravity
		if (place_meeting(x, y, objLowGravField)) {
			grav_amount = 0.2;
		} else if (place_meeting(x, y, objHighGravField)) {
			grav_amount = 0.7;
		}
		#endregion
		break;
	}
}