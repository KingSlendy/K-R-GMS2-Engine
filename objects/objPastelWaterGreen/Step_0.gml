#region Collision with block
var block = instance_place(x, y, objBlock);

if (block != noone) {
	block.image_alpha = (!instance_place_check(x + hspeed, y + vspeed, objBlock));
}
#endregion