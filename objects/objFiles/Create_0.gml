datas = [];

for (var i = 0; i < global.total_saves; i++) {
	datas[i] = {
		difficulty: "No Data",
		deaths: 0,
		time: 0,
		clear: false
	}
	
    if (file_exists(string_interp("Data{0}", i + 1))) {
        global.save_num = i;
        load_game(false);
		var data = datas[i];
		data.difficulty = global.difficulties[global.difficulty];
		data.deaths = global.deaths;
		data.time = global.time;
		data.clear = global.clear;
    }
}

cleanup_game();

menu = 0;
select = array_create(3, 0);
spacing = 16 * 10;