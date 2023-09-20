function package_MTG(load_type = undefined) {
	if (load_type != undefined) {
		switch(load_type) {
			case "save":
			var data_mtg = {
				mtg: {
					stats: global.stats_mtg,
					items: global.items_mtg,
					keys: global.keys_mtg,
					locks: global.locks_mtg,
					monsters: global.monsters_mtg,
					totals: global.totals_mtg
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
			global.locks_mtg = data.mtg.locks;
			global.monsters_mtg = data.mtg.monsters;
			global.totals_mtg = data.mtg.totals;
			break;
			
			case "cleanup":
			global.floor_current = 0;
			
			#region Arrays
			global.stats_mtg = {
				level: 0,
				health: 1,
				attack: 2,
				defense: 0,
				current_exp: 0,
				required_exp: 20,
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
			
			global.locks_mtg = {};
			
			global.monsters_mtg = [];
			
			global.totals_mtg = {
				keys_used: 0,
				kills: 0,
			}
			#endregion
			
			global.monster_skip = false;
			global.experience_gain = 0;
			break;
		}
	}
}