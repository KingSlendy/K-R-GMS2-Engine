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
grav_amount = 0.4;
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
frozen = false;

enum PLAYER_ACTIONS {
	IDLE = sprPlayerIdle,
	RUN = sprPlayerRun,
	JUMP = sprPlayerJump,
	FALL = sprPlayerFall,
	SLIDE = sprPlayerSlide
}

reset_jumps();
#endregion

if (global.difficulty == 0 && !instance_exists(objBow)) {
	instance_create_layer(x, y, "Player", objBow);
}
#endregion