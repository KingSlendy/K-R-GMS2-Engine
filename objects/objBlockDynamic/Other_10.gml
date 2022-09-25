/// @description Carry instance
if (!image_alpha) { exit; }

if (inst != noone) {
    if (collision_rectangle(old_left, old_top - global.grav, old_right, old_bottom - global.grav, inst, true, true)) {
        var tangible = function(obj) { return (obj.image_alpha == 1); }
		var carry_x = mean(bbox_left, bbox_right) - mean(old_left, old_right);
        var carry_y = bbox_top - inst.bbox_bottom - 1;
        with(inst) {                                     
            if (carry_x != 0) {                                             
                if (instance_place_check(x + carry_x, y, objBlock, tangible) == noone) {
                    x += carry_x;
                } else {                          
					while (instance_place_check(x + sign(carry_x), y, objBlock, tangible) == noone) {
						x += sign(carry_x);
					}
                }
            }
            if (carry_y > 0) {              
                if (instance_place_check(x, y + carry_y, objBlock, tangible) == noone) {
                    y += carry_y;
				} else {
					while (instance_place_check(x, y + sign(carry_y), objBlock, tangible) == noone) {
						y += sign(carry_y);
					}
                }
            }
        }
    }
}