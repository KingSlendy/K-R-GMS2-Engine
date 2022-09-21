event_inherited();
image_speed = 0;

var target = objPlayer;

if (instance_exists(target)) {
    mask_index = target.mask_index;
    sprite_index = target.sprite_index;
    image_index = target.image_index;
	
	xscale = target.xscale;
	yscale = global.grav;
	
    image_angle = target.image_angle;
    image_blend = target.image_blend;
}