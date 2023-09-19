function package_MTG(load_type = undefined) {
	if (load_type != undefined) {
		switch(load_type) {
			case "save":
			var data_mtg = {
				mtg: {
					stats_mtg: global.stats_mtg,
					items_mtg: global.items_mtg,
					keys_mtg: global.keys_mtg,
					locks_mtg: global.locks_mtg,
					monsters_mtg: global.monsters_mtg,
					totals_mtg: global.totals_mtg
				}
			}
			
			var json_mtg = json_stringify(data_mtg);
			save_file(string("Data{0}", global.save_num + 1), json_mtg, true);
			break;
			
			case "load":
			var json_mtg = load_file(string("Data{0}", global.save_num + 1), true);
			var data_mtg = json_parse(json_mtg);
			
			global.stats_mtg = data_mtg.mtg.stats_mtg;
			global.items_mtg = data_mtg.mtg.items_mtg;
			global.keys_mtg = data_mtg.mtg.keys_mtg;
			global.locks_mtg = data_mtg.mtg.locks_mtg;
			global.monsters_mtg = data_mtg.mtg.monsters_mtg;
			global.totals_mtg = data_mtg.mtg.totals_mtg;
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
				health: array_create(999, undefined),
				attack: array_create(999, undefined),
				defense: array_create(999, undefined),
				swords: array_create(999, undefined),
				shields: array_create(999, undefined),
				keys: array_create(999, undefined),
				locks: array_create(999, undefined),
				special: array_create(999, undefined),
			}
			
			global.keys_mtg = {};
			
			global.locks_mtg = {};
			
			global.monsters_mtg = array_create(999, undefined);
			
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