function package_MTG(load_type = undefined) {
	if (load_type != undefined) {
		switch(load_type) {
			case "save":
			var data_mtg = {
				mtg: {
					stats: global.stats_mtg,
					items: global.items_mtg,
					keys: global.keys_mtg,
					monsters: global.monsters_mtg
				}
			}
			
			var json = json_stringify(data);
			save_file(string("Data{0}", global.save_num + 1), json, true);
			break;
			
			case "load":
			var json = load_file(string("Data{0}", global.save_num + 1), true);
			var data = json_parse(json);
			
			global.stats_mtg = data.mtg.stats;
			global.items_mtg = data.mtg.items;
			global.keys_mtg = data.mtg.keys;
			global.monsters_mtg = data.mtg.monsters;
			break;
			
			case "cleanup":
			global.floor_current = 0;
			
			#region Arrays
			global.stats_mtg = {
				level: 0,
				current_exp: 0,
				needed_exp: 30,
				health: 1,
				attack: 2,
				defense: 0,
			}
			
			global.items_mtg = {
				health: [],
				attack: [],
				defense: [],
				swords: [],
				shields: [],
				keys: [],
				locks: [],
				special: array_create(99, undefined),
			}
			
			global.keys_mtg = {};

			global.monsters_mtg = [];
			#endregion
			
			global.monster_skip = false;
			global.experience_gain = 0;
			break;
		}
	}
}