#region Online
if (global.connected && async_load[? "type"] == network_type_data) {
	var port = async_load[? "port"];
	var buffer = async_load[? "buffer"];
	buffer_seek(buffer, buffer_seek_start, 0);
	var packet;
	
	do {
		packet = buffer_read(buffer, buffer_u8);
	} until (packet < 7 && packet != 3);

	if (port == global.online.tcp) {
		switch (packet) {
			case 0:
				//CREATED
				var __ONLINE_ID = buffer_read(buffer, buffer_string);
				var __ONLINE_found = false;
			
				for (var __ONLINE_i = 0; __ONLINE_i < (instance_number(__ONLINE_onlinePlayer) && !__ONLINE_found); __ONLINE_i++){
					if (instance_find(__ONLINE_onlinePlayer, __ONLINE_i).__ONLINE_ID == __ONLINE_ID) {
						__ONLINE_found = true;
					}
				}
			
				if (!__ONLINE_found) {
					var __ONLINE_oPlayer = instance_create_layer(0, 0, "Instances", __ONLINE_onlinePlayer);
					__ONLINE_oPlayer.__ONLINE_ID = __ONLINE_ID;
					__ONLINE_oPlayer.__ONLINE_name = buffer_read(buffer, buffer_string);
				}
				break;
		
			case 1:
				//DESTROYED
				var __ONLINE_ID = buffer_read(buffer, buffer_string);
				var __ONLINE_found = false;
			
				for (var __ONLINE_i = 0; __ONLINE_i < (instance_number(__ONLINE_onlinePlayer) && !__ONLINE_found); __ONLINE_i++){
					var __ONLINE_oPlayer = instance_find(__ONLINE_onlinePlayer, __ONLINE_i);
				
					if (__ONLINE_oPlayer.__ONLINE_ID == __ONLINE_ID) {
						instance_destroy(__ONLINE_oPlayer);
						__ONLINE_found = true;
					}
				}
				break;
		
			case 2:
				//INCOMPATIBLE VERSION
				var __ONLINE_lastVersion = buffer_read(buffer, buffer_string);
				show_message("Your tool uses the version " + __ONLINE_version + " but the oldest compatible version is " + __ONLINE_lastVersion + ".\nPlease update your tool.");
				game_end();
				exit;
		
			case 4:
				//CHAT MESSAGE
				var __ONLINE_ID = buffer_read(buffer, buffer_string);
				var __ONLINE_found = false;
				var __ONLINE_oPlayer = 0;
				
				for (var __ONLINE_i = 0; __ONLINE_i < (instance_number(__ONLINE_onlinePlayer) && !__ONLINE_found); __ONLINE_i++) {
					__ONLINE_oPlayer = instance_find(__ONLINE_onlinePlayer, __ONLINE_i);
					
					if (__ONLINE_oPlayer.__ONLINE_ID == __ONLINE_ID) {
						__ONLINE_found = true;
					}
				}
				
				if (__ONLINE_found) {
					var __ONLINE_message = buffer_read(buffer, buffer_string);
					var __ONLINE_oChatbox = instance_create_layer(0, 0, "Instances", __ONLINE_chatbox);
					__ONLINE_oChatbox.__ONLINE_message = __ONLINE_message;
					__ONLINE_oChatbox.__ONLINE_follower = __ONLINE_oPlayer;
					//if (__ONLINE_oPlayer.visible) {
						//audio_play_sound(__ONLINE_sndChatbox, 0, false);
					//}
				}
				break;
		
			case 5:
				//SOMEONE SAVED
				if (!global.online.race) {
					__ONLINE_sSaved = true;
					__ONLINE_sGravity = buffer_read(buffer, buffer_u8);
					__ONLINE_sName = buffer_read(buffer, buffer_string);
					__ONLINE_sX = buffer_read(buffer, buffer_s32);
					__ONLINE_sY = buffer_read(buffer, buffer_f64);
					__ONLINE_sRoom = buffer_read(buffer, buffer_s16);
					
					var __ONLINE_a = instance_create_layer(0, 0, "Instances", __ONLINE_playerSaved);
					__ONLINE_a.__ONLINE_name = __ONLINE_sName;
					//audio_play_sound(__ONLINE_sndSaved, 0, false);
				}
				break;
		
			case 6:
				//SELF ID
				__ONLINE_selfID = buffer_read(buffer, buffer_string);
				break;
				
			default: show_message("Received unexpected data from the server."); break;
		}
	} else if (port == global.online.udp) {
		switch (packet) {
			case 1:
				//RECEIVED MOVED
				var __ONLINE_ID = buffer_read(buffer, buffer_string);
				/*var __ONLINE_gameID = */buffer_read(buffer, buffer_string);
				var __ONLINE_found = false;
				var __ONLINE_oPlayer = 0;
				
				for (var __ONLINE_i = 0; __ONLINE_i < (instance_number(__ONLINE_onlinePlayer) && !__ONLINE_found); __ONLINE_i++){
					__ONLINE_oPlayer = instance_find(__ONLINE_onlinePlayer, __ONLINE_i);
					
					if (__ONLINE_oPlayer.__ONLINE_ID == __ONLINE_ID) {
						__ONLINE_found = true;
					}
				}
				
				if (!__ONLINE_found) {
					__ONLINE_oPlayer = instance_create_layer(0, 0, "Instances", __ONLINE_onlinePlayer);
					__ONLINE_oPlayer.__ONLINE_ID = __ONLINE_ID;
				}

				__ONLINE_oPlayer.__ONLINE_oRoom = buffer_read(buffer, buffer_u16);
				var __ONLINE_syncTime = buffer_read(buffer, buffer_u64);
				
				if (__ONLINE_oPlayer.__ONLINE_syncTime < __ONLINE_syncTime) {
					__ONLINE_oPlayer.__ONLINE_syncTime = __ONLINE_syncTime;
					__ONLINE_oPlayer.x = buffer_read(buffer, buffer_s32);
					__ONLINE_oPlayer.y = buffer_read(buffer, buffer_s32);
					__ONLINE_oPlayer.sprite_index = buffer_read(buffer, buffer_s32);
					__ONLINE_oPlayer.image_speed = buffer_read(buffer, buffer_f32);
					__ONLINE_oPlayer.image_xscale = buffer_read(buffer, buffer_f32);
					__ONLINE_oPlayer.image_yscale = buffer_read(buffer, buffer_f32);
					__ONLINE_oPlayer.image_angle = buffer_read(buffer, buffer_f32);
					__ONLINE_oPlayer.__ONLINE_name = buffer_read(buffer, buffer_string);
				}
				break;
			
			default: show_message("Received unexpected data from the server."); break;
		}
	}
}
#endregion