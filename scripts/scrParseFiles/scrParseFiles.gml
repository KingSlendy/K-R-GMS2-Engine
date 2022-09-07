function save_file(file, data, encode) {
	var saved = (encode) ?
		base64_encode(data) :
		data;
		
	var buffer = buffer_create(string_byte_length(saved), buffer_fixed, 1);
	buffer_write(buffer, buffer_text, saved);
	
	if (encode) {
		var temp = buffer;
		buffer = buffer_compress(buffer, 0, buffer_tell(buffer));
		buffer_delete(temp);
	}
	
	buffer_save(buffer, file);
	buffer_delete(buffer);
}

function load_file(file, decode) {
	var buffer = buffer_load(file);
	
	if (decode) {
		var temp = buffer;
		buffer = buffer_decompress(buffer);
		buffer_delete(temp);
	}
	
	var data = buffer_read(buffer, buffer_text);
	buffer_delete(buffer);
	
	var loaded = (decode) ?
		base64_decode(data) :
		data;
		
	return loaded;
}