#region Collision with player
var player = instance_place(x, y, objPlayer);

if (player != noone && image_alpha == 1) {
	if (status == 0) {
		battle_win();
	} else if (status == 1) {
		if (global.monster_skip) {
			battle_win();
		} else {
			room_restart();
			/*global.inCombat = true;
			global.combatIndex = ind;
			global.attackDamage = global.attack - def;
			global.defenseDamage = atk - global.defense;
			if(global.MagicCloak) {
				global.MagicHP = global.TotalKills;
			}
			global.FullHp = global.hp;
			alarm[0] = 1;*/
		} 
	} else if (status == 2) {
		kill_player();
	}
}
#endregion