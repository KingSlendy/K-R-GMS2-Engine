#region Init
depth = -10;
set_mask();
image_speed = 0.2;
xscale = global.last_xscale;
max_hspeed = 3;
max_vspeed = 9;

jump_height = [8.5, 7];
jump_total = 2;

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
#endregion