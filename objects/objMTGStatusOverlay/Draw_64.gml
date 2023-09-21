#region Left Side
if (instance_exists(objPlayer)) {
    status_sprite = objPlayer.sprite_index;
    status_image = objPlayer.image_index;
}
draw_sprite(status_sprite, status_image, 48 + sprite_get_xoffset(status_sprite), 48 + sprite_get_yoffset(status_sprite));

draw_set_font(fntMTGMenu);
draw_set_color(c_silver);
draw_text_outline(128, 60, "F", c_black);

var level = (global.stats_mtg.level == 11) ? "Level MAX" : "Level";

var stat_text = [
    level,
    "HP",
    "Atk",
    "Def",
];

for (var i = 0; i < array_length(stat_text); i++) {
    draw_text_outline(48, 128 + (8 * (i != 0)) + 48 * i, stat_text[i], c_black);
}

var key_types = [
    "yellow",
    "blue",
    "red",
];

for (var i = 0; i < array_length(key_types); i++) {
    draw_sprite_ext(sprMTGColoredKey, i, 64, 344 + 48 * i, 1, 1, 0, c_white, 1);
}
#endregion

#region Right Side
draw_set_color(c_white);
draw_set_halign(fa_right);
draw_text_outline(112, 60, global.floor_current, c_black);

var stat_info = [
    global.stats_mtg.level,
    global.stats_mtg.health,
    global.stats_mtg.attack,
    global.stats_mtg.defense,
];

draw_sprite(sprMTGProgressBarExt, -1, 46, 156);
draw_sprite_part(sprMTGProgressBarInt, -1, 0, 0, global.stats_mtg.current_exp / global.stats_mtg.required_exp * 96, 10, 46, 156);
for (var i = 0; i < array_length(stat_info); i++) {
    draw_text_outline(132, 128 + (8 * (i != 0)) + 48 * i, stat_info[i], c_black);
}

var yellow_key = (variable_struct_exists(global.keys_mtg, c_yellow)) ? global.keys_mtg[$ c_yellow] : 0;
var blue_key = (variable_struct_exists(global.keys_mtg, c_blue)) ? global.keys_mtg[$ c_blue] : 0;
var red_key = (variable_struct_exists(global.keys_mtg, c_red)) ? global.keys_mtg[$ c_red] : 0;

var key_info = [
    string("{0}", yellow_key), //Yellow
    string("{0}", blue_key), //Blue
    string("{0}", red_key), //Red
    
    /*
    string("{0}", global.items_mtg.keys), //Green
    string("{0}", global.items_mtg.keys), //Iron
    */
];
for (var i = 0; i < array_length(key_info); i++) {
    draw_text_outline(132, 328 + 48 * i, key_info[i], c_black);
}

draw_set_color(c_white);
draw_set_font(fntMTGMenu2);
draw_set_valign(fa_middle);
draw_text_outline(140, 161, string("{0} / {1}", global.stats_mtg.current_exp, global.stats_mtg.required_exp), c_black);
#endregion

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);