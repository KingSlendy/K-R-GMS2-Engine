end_game();
save_config();

#region Online
online_disconnect();
buffer_delete(__ONLINE_buffer);
#endregion