/// @description Initialize variables

old_left = bbox_left;
old_right = bbox_right;
old_top = bbox_top;
old_bottom = bbox_bottom;

inst = noone;

function carry_instance() {
	if (image_alpha != 1) { exit; }
	
	if (inst != noone) {
		var player = {
			left: (abs(global.grav) == 1) ? inst.bbox_left : inst.bbox_top,
			top: (abs(global.grav) == 1) ? inst.bbox_top : inst.bbox_left,
			right: (abs(global.grav) == 1) ? inst.bbox_right : inst.bbox_bottom,
			bottom: (abs(global.grav) == 1) ? inst.bbox_bottom : inst.bbox_right
		}
		
		var block = {
			left_place: (abs(global.grav) == 1) ? old_left : old_left - sign(global.grav),
			top_place: (abs(global.grav) == 1) ? old_top - sign(global.grav) : old_top,
			right_place: (abs(global.grav) == 1) ? old_right : old_right - sign(global.grav),
			bottom_place: (abs(global.grav) == 1) ? old_bottom - sign(global.grav) : old_bottom,
			
			left_previous: (abs(global.grav) == 1) ? old_left : old_top,
			top_previous: (abs(global.grav) == 1) ? old_top : old_left,
			right_previous: (abs(global.grav) == 1) ? old_right : old_bottom,
			bottom_previous: (abs(global.grav) == 1) ? old_bottom : old_right,
				
			left: (abs(global.grav) == 1) ? bbox_left : bbox_top,
			top: (abs(global.grav) == 1) ? bbox_top : bbox_left,
			right: (abs(global.grav) == 1) ? bbox_right : bbox_bottom,
			bottom: (abs(global.grav) == 1) ? bbox_bottom : bbox_right
		}

	    if (collision_rectangle(block.left_place, block.top_place, block.right_place, block.bottom_place, inst, true, true)) {
	        var carry_x = mean(block.left, block.right) - mean(block.left_previous, block.right_previous);
	        var carry_y = (sign(global.grav) == 1) ? block.top - player.bottom - 1 : block.bottom - player.top + 1;
			
	        with (inst) {
	            #region Detect horizontal collision
	            if (carry_x != 0) {
	                if (p_instance_place(carry_x, 0, objBlock) == null) {
	                	p_x(X + carry_x);
	                } else {
						while (p_instance_place(sign(carry_x), 0, objBlock) == null) {
							p_x(X + sign(carry_x));
						}
	                }
	            }
	            #endregion
	            
	            #region Detect vertical collision
	            if (abs(carry_y) > 0) {
	                if (p_instance_place(0, carry_y, objBlock) == null) {
	                    p_y(Y + carry_y);
					} else {
						while (p_instance_place(0, sign(carry_y), objBlock) == null) {
							p_y(Y + sign(carry_y));
						}
	                }
	            }
	            #endregion
	            
	            #region Detect diagonal collision
				
	            #endregion
	        }
	    }
	}	
}

function push_instance() {
	if (image_alpha != 1) { exit; }
	
	if (inst != noone) {
	    if (place_meeting(x, y, inst)) {
	        var move_x = 0, move_y = 0;
			
			var player = {
				left: (abs(global.grav) == 1) ? inst.bbox_left : inst.bbox_top,
				top: (abs(global.grav) == 1) ? inst.bbox_top : inst.bbox_left,
				right: (abs(global.grav) == 1) ? inst.bbox_right : inst.bbox_bottom,
				bottom: (abs(global.grav) == 1) ? inst.bbox_bottom : inst.bbox_right
			}
			
			var block = {
				left_previous: (abs(global.grav) == 1) ? old_left : old_top,
				top_previous: (abs(global.grav) == 1) ? old_top : old_left,
				right_previous: (abs(global.grav) == 1) ? old_right : old_bottom,
				bottom_previous: (abs(global.grav) == 1) ? old_bottom : old_right,
				
				left: (abs(global.grav) == 1) ? bbox_left : bbox_top,
				top: (abs(global.grav) == 1) ? bbox_top : bbox_left,
				right: (abs(global.grav) == 1) ? bbox_right : bbox_bottom,
				bottom: (abs(global.grav) == 1) ? bbox_bottom : bbox_right
			}
			
	        #region Push horizontally
		    if (player.bottom - (Y - inst.yold) >= block.top_previous && player.top - (Y - inst.yold) <= block.bottom_previous) {
		        if (player.left - (X - inst.xold) >= block.right_previous) {
		            move_x = block.right - player.left + 1;
		            move_x += ((X + move_x) % 2 == 1.5);
		        } else if (player.right - (X - inst.xold) <= block.left_previous) {
		            move_x = block.left - player.right - 1;
		            move_x -= ((X + move_x) % 2 == 0.5);
		        }
					
		        if (move_x != 0) {
		            with (inst) {
		                if (p_instance_place(move_x, 0, objBlock) == null) {
		                    p_x(X + move_x);
		                }
		            }
		        }
		    }	
	        #endregion
	        
	        #region Push vertically
	        if (player.right - (X - inst.xold) >= block.left_previous && player.left - (X - inst.xold) <= block.right_previous) {
	            if (player.top - (Y - inst.yold) >= block.bottom_previous) {
	                move_y = block.bottom - player.top + 1;
	                move_y += ((Y + move_y) % 2 == 1.5);
	            } else if (player.bottom - (Y - inst.yold) <= block.top_previous) {
	                move_y = block.top - player.bottom - 1;
	                move_y -= ((Y + move_y) % 2 == 0.5);
	            }
				
	            if (move_y != 0) {
	                with (inst) {
	                    if (p_instance_place(0, move_y, objBlock) == null) {
	                        p_y(Y + move_y);
	                    }
	                }
	            }
	        }
	        #endregion
	    }
	}
}