if (instance_number(objWorld) > 1) {
	instance_destroy();
}

audio_master_gain(0);
pause_delay = global.total_pause_delay;
pause_screen = noone;

#region Online
__ONLINE_socket = undefined;
__ONLINE_udpsocket = undefined;
__ONLINE_buffer = buffer_create(1024, buffer_grow, 1);
__ONLINE_selfID = "";
__ONLINE_selfGameID = "";
__ONLINE_version = "1.1.5";
__ONLINE_pExists = false;
__ONLINE_pX = 0;
__ONLINE_pY = 0;
__ONLINE_t = 0;
__ONLINE_heartbeat = 0;
__ONLINE_stoppedFrames = 0;
__ONLINE_sGravity = 0;
__ONLINE_sX = 0;
__ONLINE_sY = 0;
__ONLINE_sRoom = 0;
__ONLINE_sSaved = false;

function online_connect() {
	__ONLINE_socket = network_create_socket(network_socket_tcp);
	var connected = network_connect_raw(__ONLINE_socket, global.online.server, global.online.tcp);
	
	if (connected < 0) {
		online_disconnect();
		show_message("Couldn't connect to the server");
		return;
	}
	
	__ONLINE_selfGameID = md5_string_unicode(global.game_name) + global.online.password;
	buffer_seek(__ONLINE_buffer, buffer_seek_start, 0);
	buffer_write(__ONLINE_buffer, buffer_u8, 3);
	buffer_write(__ONLINE_buffer, buffer_string, global.online.name);
	buffer_write(__ONLINE_buffer, buffer_string, __ONLINE_selfGameID);
	buffer_write(__ONLINE_buffer, buffer_string, global.game_name);
	buffer_write(__ONLINE_buffer, buffer_string, __ONLINE_version);
	buffer_write(__ONLINE_buffer, buffer_u8, global.online.password != "");
	buffer_write_uv(__ONLINE_buffer, 0, buffer_tell(__ONLINE_buffer));
	network_send_raw(__ONLINE_socket, __ONLINE_buffer, buffer_tell(__ONLINE_buffer));
	
	__ONLINE_udpsocket = network_create_socket(network_socket_udp);
	buffer_seek(__ONLINE_buffer, buffer_seek_start, 0);
	buffer_write(__ONLINE_buffer, buffer_u8, 0);
	network_send_udp_raw(__ONLINE_udpsocket, global.online.server, global.online.udp, __ONLINE_buffer, buffer_tell(__ONLINE_buffer));
}

function online_disconnect() {
	if (instance_exists(__ONLINE_onlinePlayer)) {
		instance_destroy(__ONLINE_onlinePlayer);
	}
	
	if (!is_undefined(__ONLINE_socket)) {
		network_destroy(__ONLINE_socket);
		__ONLINE_socket = undefined;
	}
	
	if (!is_undefined(__ONLINE_udpsocket)) {
		network_destroy(__ONLINE_udpsocket);
		__ONLINE_udpsocket = undefined;
	}
	
	global.connected = false;
}

function buffer_write_uv(buffer, offset, value) {
	var offsets = [0x000000, 0x000080, 0x004080, 0x204080];
	var used_bits = [1, 2, 3, 3];
	var prefix_bits = [1, 2, 4, 0];	
	var length = 4;
		
	for (var i = 1; i <= 3; i++) {
		if (value < offsets[i]) {
			length = i;
			break;
		}
	}
		
	length--;
	value = ((value - offsets[length]) << used_bits[length]) | prefix_bits[length];
	buffer_poke(buffer, offset, buffer_string, value);
}

function buffer_read_uv(buffer, offset) {
}
#endregion