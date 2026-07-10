backdrop = null;
type = 1 + irandom(10);
if (sprite_exists("sprBkgMTGBattle" + type)) {
	backdrop = asset_get_index("sprBkgMTGBattle" + type);
}