/// @description Initialize variables

old_left = bbox_left;
old_right = bbox_right;
old_top = bbox_top;
old_bottom = bbox_bottom;

inst = noone;

function carry_instance() {
	if (image_alpha != 1) { exit; }
	
	if (inst != noone) {
	    if (collision_rectangle(old_left, old_top - global.grav, old_right, old_bottom - global.grav, inst, true, true)) {
	        var carry_x = mean(bbox_left, bbox_right) - mean(old_left, old_right);
	        var carry_y = bbox_top - inst.bbox_bottom - 1;
			
	        with (inst) {                                     
	            if (carry_x != 0) {
					#region Solid collision
					/*if (place_free(x + carry_x, y)) {
						x += carry_x;
					} else {
						move_contact_solid(180 * (carry_x < 0), abs(carry_x));
					}*/
					#endregion
					
					#region Non-Solid collision
	                if (instance_place_check(x + carry_x, y, objBlock, tangible_collision) == null) {
	                    x += carry_x;
	                } else {
						while (instance_place_check(x + sign(carry_x), y, objBlock, tangible_collision) == null) {
							x += sign(carry_x);
						}
	                }
	                #endregion
	            }
	            if (carry_y > 0) {
	            	#region Solid collision
					/*if (place_free(x, y + carry_y)) {
						y += carry_y;
					} else {
						move_contact_solid(270, carry_y);
					}*/
					#endregion
					
					#region Non-Solid collision
	                if (instance_place_check(x, y + carry_y, objBlock, tangible_collision) == null) {
	                    y += carry_y;
					} else {
						while (instance_place_check(x, y + sign(carry_y), objBlock, tangible_collision) == null) {
							y += sign(carry_y);
						}
	                }
	                #endregion
	            }
	        }
	    }
	}	
}

function push_instance() {
	if (image_alpha != 1) { exit; }
	
	if (inst != noone) {
	    if (place_meeting(x, y, inst)) {
	        var move_x = 0, move_y = 0;
			
	        #region Push horizontally
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
	                	#region Solid collision
	                	/*if (place_free(x + move_x, y)) {
	                		x += move_x;
	                	}*/
	                	#endregion
	                	
	                	#region Non-Solid collision
	                    if (instance_place_check(x + move_x, y, objBlock, tangible_collision) == null) {
	                        x += move_x;
	                    }
	                    #endregion
	                }
	            }
	        }
	        #endregion
	        
	        #region Push vertically
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
	                	#region Solid collision
	                	/*if (place_free(x, y + move_y)) {
	                		y += move_y;
	                	}*/
	                	#endregion
	                	
	                	#region Non-Solid collision
	                    if (instance_place_check(x, y + move_y, objBlock, tangible_collision) == null) {
	                        y += move_y;
	                    }
	                    #endregion
	                }
	            }
	        }
	        #endregion
	    }
	}
}