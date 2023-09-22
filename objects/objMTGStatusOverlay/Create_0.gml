status_sprite = noone;
status_image = -1;

tick = 0;

overlay_init = function() {
    stats = {
        level: global.stats_mtg.level,
        health: global.stats_mtg.health,
        attack: global.stats_mtg.attack,
        defense: global.stats_mtg.defense,
    };
    
    keys = {
        yellow: (variable_struct_exists(global.keys_mtg, c_yellow)) ? global.keys_mtg[$ c_yellow] : 0,
        blue: (variable_struct_exists(global.keys_mtg, c_blue)) ? global.keys_mtg[$ c_blue] : 0,
        red: (variable_struct_exists(global.keys_mtg, c_red)) ? global.keys_mtg[$ c_red] : 0,
    };
    
    xp = {
        current: global.stats_mtg.current_exp,
        needed: global.stats_mtg.needed_exp,
        gained: global.experience_gain,
        summed: 0,
        total: 0
    };
}

overlay_init();