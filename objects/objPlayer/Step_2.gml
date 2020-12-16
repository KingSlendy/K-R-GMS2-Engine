#region Killer Checking
check_killer();
#endregion

#region Screen Border
if (global.outside_kills && outside_room()) {
	kill_player();
}
#endregion