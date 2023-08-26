#region Init
set_mask();
xscale = global.last_xscale;
image_angle = global.save_player.sangle;

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
spd_mod = {
	//Common 
	fast: 0,
	slow: 0,
	
	//RBN Speed
	auto: 0,
	buffer: 0
}

grav_mod = {
	//Common 
	low: 0,
	high: 0,
	
	//RBN Grav
	zero: 0,
	anti: 0
};
#endregion

#region Jump Variables
jump_height = [8.5, 7];
jump_total = 2;
jump_velocity = 1;

vine_mod = {
	//Jungle Adventure
	stick: 0,
	lowgrav: 0,
	fire: 0,
	
	//RBN Light
	zerograv: 0,
	
	//Effects
	count: 0
};
#endregion

package_load();

#region Collision and Actions
on_block = false;
on_ice = false;

on_conveyor = false;
on_elevator = false;

on_platform = false;
on_ladder = false;

lunar_start = false;

test_dist = {
	orig: 0,
	xpos: 0,
	ypos: 0,
	xneg: 0,
	yneg: 0
}

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

xsafe = x;
ysafe = y;

dynamic_collision(true);

hit = 0;
hit_x = x;
hit_y = y;
#endregion
#endregion