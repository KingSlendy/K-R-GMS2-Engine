#region Physics and Collision
xprevious = x;
yprevious = y;

x += hspd;
y += vspd;

#region Collision with blocks
var block = instance_place_check(x, y, objBlock, tangible_collision);

if (moving && instance_place_check(x, y, objPastelWaterGreen, tangible_collision) == null) {
	if (block != null) {
		x = xprevious;
		y = yprevious;
	
		//Detect horizontal collision
		if (instance_place_check(x + hspd, y, objBlock, tangible_collision) != null) {
			while (instance_place_check(x + sign(hspd), y, objBlock, tangible_collision) == null) {
				x += sign(hspd);
			}
	
			hspd = 0;
		}

		//Detect vertical collision
		if (instance_place_check(x, y + vspd, objBlock, tangible_collision) != null) {
			while (instance_place_check(x, y + sign(vspd), objBlock, tangible_collision) == null) {
				y += sign(vspd);
			}
	
			vspd = 0;
		}

		//Detect diagonal collision
		if (instance_place_check(x + hspd, y + vspd, objBlock, tangible_collision) != null) {
			hspd = 0;
		}

		x += hspd;
		y += vspd;
		moving = false;
	}
}
#endregion
#endregion