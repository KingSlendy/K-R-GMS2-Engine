if (!variable_struct_exists(global.keys_mtg, image_blend)) {
    global.keys_mtg[$ image_blend] = 0;
}

if (num > -1) {
    global.keys_mtg[$ image_blend] += amount;
}
event_inherited();