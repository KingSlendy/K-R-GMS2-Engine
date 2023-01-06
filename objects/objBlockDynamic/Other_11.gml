/// @description Push instance
//with(objBlockDynamic) { solid = false; }

if (inst != noone) {
    if (place_meeting(x, y, inst)) {
        var move_x = 0, move_y = 0;
		
        //Push horizontally
        if (inst.bbox_bottom - (inst.y - inst.yold) >= old_top && inst.bbox_top - (inst.y - inst.yold) <= old_bottom) {
            if (inst.bbox_left - (inst.x - inst.xold) >= old_right) {
                move_x = bbox_right - inst.bbox_left + 1;
                move_x += ((inst.x + move_x) % 2 == 1.5);
            } else if (inst.bbox_right - (inst.x - inst.xold) <= old_left) {
                move_x = bbox_left - inst.bbox_right - 1;
                move_x -= ((inst.x + move_x) % 2 == 0.5);
            }
			
            if (move_x != 0) {
                with (inst) {
                    if (instance_place_check(x + move_x, y, objBlock, tangible_collision) == null) {
                        x += move_x;
                    }
                }
            }
        }
        
        //Push vertically
        if (inst.bbox_right - (inst.x - inst.xold) >= old_left && inst.bbox_left - (inst.x - inst.xold) <= old_right) {
            if (inst.bbox_top - (inst.y - inst.yold) >= old_bottom) {
                move_y = bbox_bottom - inst.bbox_top + 1;
                move_y += ((inst.y + move_y) % 2 == 1.5);
            } else if (inst.bbox_bottom - (inst.y - inst.yold) <= old_top) {
                move_y = bbox_top - inst.bbox_bottom - 1;
                move_y -= ((inst.y + move_y) % 2 == 0.5);
            }
			
            if (move_y != 0) {
                with (inst) {
                    if (instance_place_check(x, y + move_y, objBlock, tangible_collision) == null) {
                        y += move_y;
                    }
                }
            }
        }
    }
}