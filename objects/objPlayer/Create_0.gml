#region Init
set_mask();
xscale = global.last_xscale;

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

#region Speed Modifiers
hspd_mod = 1;
#endregion

#region Jump Variables
jump_height = [8.5, 7];
jump_total = 2;
#endregion

#region Collision and Actions
on_block = false;
on_ladder = false;

lunar_start = false;
test_dist = 0;
test_dist_xpos = 0;
test_dist_ypos = 0;
test_dist_xneg = 0;
test_dist_yneg = 0;

frozen = false;

enum PLAYER_ACTIONS {
	//Standard actions
	IDLE = sprPlayerIdle,
	RUN = sprPlayerRun,
	JUMP = sprPlayerJump,
	FALL = sprPlayerFall,
	SLIDE = sprPlayerSlide,
	
	//Climbing actions
	CLIMB = sprPlayerClimb,
	CLIMB_HORIZONTAL = sprPlayerClimbHorizontal,
	CLIMB_VERTICAL = sprPlayerClimbVertical,
	
	//Transform actions
	DOTKID = sprPlayerDotkid,
	LUNARKID = sprPlayerLunarkid,
	LINEKID = sprPlayerLinekid
}

reset_jumps();

hit = 0;
hit_x = x;
hit_y = y;
#endregion
#endregion