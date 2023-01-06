/// @description Carry instance
//with (objBlockDynamic) { solid = false; }
if (image_alpha != 1) { exit; }

if (inst != noone) {
    if (collision_rectangle(old_left, old_top - global.grav, old_right, old_bottom - global.grav, inst, true, true)) {
        var carry_x = mean(bbox_left, bbox_right) - mean(old_left, old_right);
        var carry_y = bbox_top - inst.bbox_bottom - 1;
		
        with (inst) {                                     
            if (carry_x != 0) {
				//if (place_free(x + carry_x, y)) {
                if (instance_place_check(x + carry_x, y, objBlock, tangible_collision) == null) {
                    x += carry_x;
                } else {
					//move_contact_solid(180 * (carry_x < 0), abs(carry_x));
					while (instance_place_check(x + sign(carry_x), y, objBlock, tangible_collision) == null) {
						x += sign(carry_x);
					}
                }
            }
            if (carry_y > 0) {
				//if (place_free(x, y + carry_y)) {
                if (instance_place_check(x, y + carry_y, objBlock, tangible_collision) == null) {
                    y += carry_y;
				} else {
					//move_contact_solid(270, carry_y);
					while (instance_place_check(x, y + sign(carry_y), objBlock, tangible_collision) == null) {
						y += sign(carry_y);
					}
                }
            }
        }
    }
}

//with(objBlockDynamic) { solid = true; }   