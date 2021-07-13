datas = [];

for (var i = 0; i < global.total_saves; i++) {
	var exists = file_exists(string_interp("Data{0}", i + 1));
	
    if (exists) {
        global.save_num = i;
        load_game(false);
    }
	
	datas[i] = {
		difficulty: (exists) ? global.difficulties[global.difficulty] : "No Data",
		deaths: global.deaths,
		time: global.time,
		clear: global.clear,
		items: global.items
	};
}

cleanup_game();

enum MENU_FILES {
	DATA,
	DIFFICULTY
}

menu = MENU_FILES.DATA;
select = array_create(2, 0);
spacing = 16 * 10;

#region Item Images
images_secrets = [];

for (var i = 0; i < array_length(global.items.secrets); i++) {
	images_secrets[i] = asset_get_index(string_interp("sprItemSecret{0}", i + 1));
}

images_bosses = [];

for (var i = 0; i < array_length(global.items.bosses); i++) {
	images_bosses[i] = asset_get_index(string_interp("sprItemBoss{0}", i + 1));
}
#endregion