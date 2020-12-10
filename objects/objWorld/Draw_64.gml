#region Pause Overlay
if (global.game_paused) {
	draw_sprite(pause_screen, 0, 0, 0);
	
	draw_set_alpha(0.4);
	draw_set_color(c_black);
	draw_rectangle(0, 0, view_wport[0], view_hport[0], false);
	draw_set_alpha(1);
}
#endregion