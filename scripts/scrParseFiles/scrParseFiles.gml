function save_file(file, data, encode) {
	var saved = (encode) ?
		string_to_binary(data) :
		data;
		
	var buffer = buffer_create(string_byte_length(saved) + 1, buffer_fixed, 1);
	buffer_write(buffer, buffer_string, saved);
	
	if (encode) {
		buffer = buffer_compress(buffer, 0, buffer_tell(buffer));
	}
	
	buffer_save(buffer, file);
	buffer_delete(buffer);
}

function load_file(file, decode) {
	var buffer = buffer_load(file);
	
	if (decode) {
		buffer = buffer_decompress(buffer);
	}
	
	var data = buffer_read(buffer, buffer_string);
	buffer_delete(buffer);
	
	var loaded = (decode) ?
		binary_to_string(data) :
		data;
		
	return loaded;
}

function string_to_binary(str) {
	var binary = "";
    var length = string_length(str);
	
    repeat (length) {
        var byte = ord(string_char_at(str, length));
		
        repeat (8) {
			binary = string(byte & 1) + binary;
            byte = byte >> 1;
        }
		
        length -= 1;
    }
	
    return binary;
}

function binary_to_string(bin) {
	var str = "";
	var length = string_length(bin);
	
	for (var i = 1; i <= length; i += 8) {
		var byte = string_copy(bin, i, 8);
		var num = 0;
		
		for (var j = 8; j >= 1; j--) {
			num += power(2, 8 - j) * real(string_char_at(byte, j));
		}
		
		str += chr(num);
	}
	
	return str;
}