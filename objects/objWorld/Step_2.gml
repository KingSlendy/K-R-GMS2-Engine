#region Online
if (global.connected) {
	var __ONLINE_p = objPlayer;
	var __ONLINE_exists = instance_exists(__ONLINE_p);
	var __ONLINE_X = __ONLINE_pX;
	var __ONLINE_Y = __ONLINE_pY;

	if (__ONLINE_exists) {
		if (__ONLINE_exists != __ONLINE_pExists) {
			//SEND PLAYER CREATE
			buffer_seek(__ONLINE_buffer, buffer_seek_start, 0);
			buffer_write(__ONLINE_buffer, buffer_u8, 0);
			buffer_write_uv(__ONLINE_buffer);
			network_send_raw(__ONLINE_socket, __ONLINE_buffer, buffer_tell(__ONLINE_buffer));
		}
		
		__ONLINE_X = __ONLINE_p.x;
		__ONLINE_Y = __ONLINE_p.y;
		__ONLINE_stoppedFrames++;
	
		if (__ONLINE_pX != __ONLINE_X || __ONLINE_pY != __ONLINE_Y || is_pressed(vk_anykey) || is_released(vk_anykey)) {
			__ONLINE_stoppedFrames = 0;
		}
		
		if (__ONLINE_stoppedFrames < 5 || __ONLINE_t < 3) {
			if (__ONLINE_t >= 3) {
				__ONLINE_t = 0;
			}
			
			//SEND PLAYER MOVED
			if (__ONLINE_selfID != "") {
				buffer_seek(__ONLINE_buffer, buffer_seek_start, 0);
				buffer_write(__ONLINE_buffer, buffer_u8, 1);
				buffer_write(__ONLINE_buffer, buffer_string, __ONLINE_selfID);
				buffer_write(__ONLINE_buffer, buffer_string, __ONLINE_selfGameID);
				buffer_write(__ONLINE_buffer, buffer_u16, room);
				buffer_write(__ONLINE_buffer, buffer_u64, current_time);
				buffer_write(__ONLINE_buffer, buffer_s32, __ONLINE_X);
				buffer_write(__ONLINE_buffer, buffer_s32, __ONLINE_Y);
				buffer_write(__ONLINE_buffer, buffer_s32, __ONLINE_p.sprite_index);
				buffer_write(__ONLINE_buffer, buffer_f32, __ONLINE_p.image_speed);
				buffer_write(__ONLINE_buffer, buffer_f32, __ONLINE_p.image_xscale * __ONLINE_p.xscale);
				buffer_write(__ONLINE_buffer, buffer_f32, __ONLINE_p.image_yscale * global.grav);
				buffer_write(__ONLINE_buffer, buffer_f32, __ONLINE_p.image_angle);
				buffer_write(__ONLINE_buffer, buffer_string, global.online.name);
				network_send_udp_raw(__ONLINE_udpsocket, global.online.server, global.online.udp, __ONLINE_buffer, buffer_tell(__ONLINE_buffer));
			}
		}
		
		__ONLINE_t++;
		
		if (is_pressed(vk_space)) {
			var __ONLINE_message = get_string("Say something", "");
			__ONLINE_message = string_replace_all(__ONLINE_message, "\n", "\\n");
			var __ONLINE_message_length = string_length(__ONLINE_message);
			
			if (__ONLINE_message_length > 0) {
				var __ONLINE_message_max_length = 300;
				
				if (__ONLINE_message_length > __ONLINE_message_max_length) {
					__ONLINE_message = string_copy(__ONLINE_message, 0, __ONLINE_message_max_length);
				}
				
				buffer_seek(__ONLINE_buffer, buffer_seek_start, 0);
				buffer_write(__ONLINE_buffer, buffer_u8, 4);
				buffer_write(__ONLINE_buffer, buffer_string, __ONLINE_message);
				buffer_write_uv(__ONLINE_buffer);
				network_send_raw(__ONLINE_socket, __ONLINE_buffer, buffer_tell(__ONLINE_buffer));
				
				var __ONLINE_oChatbox = instance_create_layer(0, 0, "Instances", objOnlineChatBox);
				__ONLINE_oChatbox.__ONLINE_message = __ONLINE_message;
				__ONLINE_oChatbox.__ONLINE_follower = __ONLINE_p;
				audio_play_sound(sndOnlineChatBox, 0, false);
			}
		}
	} else {
		if (__ONLINE_exists != __ONLINE_pExists) {
			// SEND PLAYER DESTROYED
			buffer_seek(__ONLINE_buffer, buffer_seek_start, 0);
			buffer_write(__ONLINE_buffer, buffer_u8, 1);
			buffer_write_uv(__ONLINE_buffer);
			network_send_raw(__ONLINE_socket, __ONLINE_buffer, buffer_tell(__ONLINE_buffer));
		}
	}

	__ONLINE_pExists = __ONLINE_exists;
	__ONLINE_pX = __ONLINE_X;
	__ONLINE_pY = __ONLINE_Y;
	__ONLINE_heartbeat += 1 / game_get_speed(gamespeed_fps);
	
	if (__ONLINE_heartbeat > 3) {
		//SEND PLAYER HEARTBEAT
		__ONLINE_heartbeat = 0;
		buffer_seek(__ONLINE_buffer, buffer_seek_start, 0);
		buffer_write(__ONLINE_buffer, buffer_u8, 2);
		buffer_write_uv(__ONLINE_buffer);
		network_send_raw(__ONLINE_socket, __ONLINE_buffer, buffer_tell(__ONLINE_buffer));
	}
}
#endregion