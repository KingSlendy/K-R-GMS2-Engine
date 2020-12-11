function save_string(file, data, encode) {
	var saved = (encode) ?
		compress_string(string_to_binary(data)) :
		data;
		
	var buffer = buffer_create(string_byte_length(saved) + 1, buffer_fixed, 1);
	buffer_write(buffer, buffer_string, saved);
	buffer_save(buffer, file);
	buffer_delete(buffer);
}

function load_string(file, decode) {
	var buffer = buffer_load(file);
	var data = buffer_read(buffer, buffer_string);
	buffer_delete(buffer);
	
	var loaded = (decode) ?
		binary_to_string(decompress_string(data)) :
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

function compress_string(str) {
	var compressed = "";
	var prev_char = string_char_at(str, 1);
	var count = 0;
	var prev_count = 0;
	var length = string_length(str);

	for (var i = 1; i <= length + 1; i++) {
	    var char = string_char_at(str, i);
    
	    if (char != prev_char) {
	        if (count != prev_count) {
	            compressed += string_interp("-{0}-{1}", count, prev_char);
	        } else {
	            compressed += prev_char;
	        }
        
	        prev_count = count;
	        count = 0;
	    }
    
	    prev_char = char;
	    count++;
	}

	compressed = string_delete(compressed, 1, 1);
	return compressed;
}

function decompress_string(str) {
	var decompressed = "";
	var sections = string_split(str, "-");
	var length = array_length(sections);

	for (var i = 0; i < length; i += 2) {
	    var count = real(sections[i]);
	    var chars = sections[i + 1];
    
	    for (var j = 1; j <= string_length(chars); j++) {
	        repeat (count) {
	            decompressed += string_char_at(chars, j);
	        }
	    }
	}

	return decompressed;
}