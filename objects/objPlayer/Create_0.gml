set_mask();
xscale = global.last_xscale;
if (global.forms.linekid) {
	image_angle = global.save_player.sangle;
}

#region Local Speed
hspd = 0;
vspd = 0;
grav = 0;
#endregion

#region Max Speed
max_hspd = 3;
max_vspd = 9;
grav_amount = (global.forms.lunarkid) ? 0 : 0.4;
#endregion

#region Jump Variables
jump_height = [8.5, 7];
jump_total = 2;
jump_velocity = 1;
#endregion

package_load();

#region Collisions
on_block = false;
on_ice = false;
on_auto = false;

for (var i = 0; i < 5; i++) {
	test_dist[i] = 0;
}

on_conveyor = false;
on_elevator = false;

on_platform = false;
on_ladder = false;
#endregion

lunar_start = false;

test_dist = {
	orig: 0,
	xpos: 0,
	ypos: 0,
	xneg: 0,
	yneg: 0
}

frozen = false;

skins = {
	"Normal": {
		"Idle": sprPlayerIdle,
		"Run": sprPlayerRun,
		"Jump": sprPlayerJump,
		"Fall": sprPlayerFall,
		"Slide": sprPlayerSlide,
		
		"Climb": sprPlayerClimb,
		"Climb_Horizontal": sprPlayerClimbHorizontal,
		"Climb_Vertical": sprPlayerClimbVertical,
		
		"Dotkid": sprPlayerDotkid,
		"Lunarkid": sprPlayerLunarkid,
		"Linekid": sprPlayerLinekid
	}
};

#region Actions
lunar_start = false;
frozen = false;

skin = "Normal";
reset_jumps();

xsafe = x;
ysafe = y;

dynamic_collision(true);

hit = 0;
hit_x = x;
hit_y = y;
#endregion