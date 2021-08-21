#region Init
set_mask();
image_speed = 0.2;
xscale = global.last_xscale;
hspd = 0;
vspd = 0;
grav = 0;
max_hspd = 3;
max_vspd = 9;
grav_amount = 0.4;

jump_height = [8.5, 7];
jump_total = 2;

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

if (global.auto_save) {
	save_game(true);
	global.auto_save = false;
}

if (global.difficulty == 0 && !instance_exists(objBow)) {
	instance_create_layer(x, y, "Player", objBow);
}
#endregion