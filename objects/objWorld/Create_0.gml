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
__ONLINE_version = "1.1.9";
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
	__ONLINE_selfGameID = md5_string_unicode(global.game_name) + global.online.password;
	__ONLINE_socket = network_create_socket(network_socket_tcp);
	var connected = network_connect_raw(__ONLINE_socket, global.online.server, global.online.tcp);
	
	if (connected < 0) {
		online_disconnect();
		show_message("Couldn't connect to the server");
		return;
	}
	
	buffer_seek(__ONLINE_buffer, buffer_seek_start, 0);
	buffer_write(__ONLINE_buffer, buffer_u8, 3);
	buffer_write(__ONLINE_buffer, buffer_string, global.online.name);
	buffer_write(__ONLINE_buffer, buffer_string, __ONLINE_selfGameID);
	buffer_write(__ONLINE_buffer, buffer_string, global.game_name);
	buffer_write(__ONLINE_buffer, buffer_string, __ONLINE_version);
	buffer_write(__ONLINE_buffer, buffer_u8, global.online.password != "");
	buffer_write_uv(__ONLINE_buffer);
	network_send_raw(__ONLINE_socket, __ONLINE_buffer, buffer_tell(__ONLINE_buffer));
	
	__ONLINE_udpsocket = network_create_socket(network_socket_udp);
	buffer_seek(__ONLINE_buffer, buffer_seek_start, 0);
	buffer_write(__ONLINE_buffer, buffer_u8, 0);
	network_send_udp_raw(__ONLINE_udpsocket, global.online.server, global.online.udp, __ONLINE_buffer, buffer_tell(__ONLINE_buffer));
}

function online_disconnect() {
	if (instance_exists(objOnlinePlayer)) {
		instance_destroy(objOnlinePlayer);
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

function buffer_write_uv(buffer) {
	var value = buffer_tell(buffer);
	buffer_seek(buffer, buffer_seek_start, 0);
	var data = [];
	
	for (var i = 0; i < value; i++) {
		data[i] = buffer_read(buffer, buffer_u8);
	}
	
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
	buffer_seek(buffer, buffer_seek_start, 0);
	
	repeat (length + 1) {
		buffer_write(buffer, buffer_u8, value & 0xFF);
		value = value >> 8;
	}
	
	length = array_length(data);
	
	for (var i = 0; i < length; i++) {
		buffer_write(buffer, buffer_u8, data[i]);
	}
}

function buffer_read_uv(buffer) {
	var first_byte = buffer_read(buffer, buffer_u8);
	var length = 3;
		
	for (var i = 0; i < 3; i++) {
		if (first_byte & power(2, i) > 0) {
			length = i;
			break;
		}
	}
		
	repeat (length) {
		buffer_read(buffer, buffer_u8);
	}
}
#endregion