amount_font = noone;
if (!font_exists(amount_font)) {
	var mapstring = "0123456789+";
	amount_font = font_add_sprite_ext(sprFntMTGAmount, mapstring, 0, 0);
}

vspeed = -1;
tick = 0;
amount = 0;