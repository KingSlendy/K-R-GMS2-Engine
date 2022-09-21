#region Variable and Input Checks
grav = grav_amount * global.grav;

var dir_left = is_held(global.controls.left);
var dir_right = is_held(global.controls.right);
var dir_down = is_held(global.controls.down);
var dir_up = is_held(global.controls.up);
var dir = 0;

var tangible = function(obj) { return (obj.image_alpha == 1); }
#endregion

#region Transformations
if (global.forms.lunarkid) { //Lunar Lander, aka "Rocket"
	if (is_pressed(global.controls.jump) && global.forms.vkid) {
		player_jump();
	}

    if ((grav_amount == 0) && (dir_left || dir_right || dir_up || dir_down)) {
        lunar_start = true;
        grav_amount = 0.008;
    }
            
    if (dir_up) { 
		motion_add((image_angle + 90), 0.013); 
	}
    
	image_angle = (image_angle + 360 + (dir_left - dir_right)) % 360;
        
    global.player.angle = image_angle;
    sprite_index = PLAYER_ACTIONS.LUNARKID;
} else if (global.forms.linekid) {
	#region Linekid functionality (I'm only putting it in a region cause it's way too fucking long lol)
    image_angle = global.player.angle;
	if (dir_up || dir_down) {
		if (((global.player.angle > 0 && global.player.angle <= 90) || (global.player.angle > 180 && global.player.angle <= 270) 
		&& instance_place_check(x - 2, y, objBlock, tangible) == noone || instance_place_check(x + 2, y, objBlock, tangible) == noone)
		|| instance_place_check(x, y - 2, objBlock, tangible) == noone || instance_place_check(x, y + 2, objBlock, tangible) == noone) {
			global.player.angle = (global.player.angle + (dir_up - dir_down) * 3) % 360;
		}
	}
        
    if (on_block == noone && instance_place_check(x, y, objBlock, tangible) == noone) {
        if (instance_place_check(x, y, objBlock, tangible) == noone) {
            test_dist = 0;
                
			while (instance_place_check(x, (y + test_dist) + 0.05, objBlock, tangible) == noone && test_dist < 2) {
				test_dist += 0.05;

            if (test_dist < 2) { 
				y += test_dist; 
			}
        }
    }
        
    first_move = 0;
    last_move_last = 0;
    x_back = x; 
    y_back = y;

    blah = 0;
	if (true) {
        last_move = 0;
		
		var list = ds_list_create();
        var line_place = instance_place_list(x, y, objBlock, list, false); 
		
        for (var i = 0; i < line_place; i++) {
            if ((ds_list_find_value(line_place, i)).image_alpha == 1) {
                test_dist_xpos = 0;
                test_dist_ypos = 0;
                test_dist_xneg = 0;
                test_dist_yneg = 0;
                        
                if (blah) {
                    if (first_move == 1) { 
						test_dist_xpos = 99; 
					} else if (first_move == 2) { 
						test_dist_xneg = 99; 
					} else if (first_move == 3) { 
						test_dist_ypos = 99; 
					} else if (first_move == 4) { 
						test_dist_yneg = 99; 
					}
                }
                        
                if (last_move == 1) { 
					test_dist_xneg = 99; 
				} else if (last_move == 2) { 
					test_dist_xpos = 99; 
				} else if (last_move == 3) { 
					test_dist_yneg = 99; 
				} else if (last_move == 4) { 
					test_dist_ypos = 99; 
				}
                        
				while (instance_place(x + test_dist_xpos, y, ds_list_find_value(line_place, i)) == noone && test_dist_xpos < 3) {
					test_dist_xpos += 0.2;
				} 
				while (instance_place(x - test_dist_xneg, y, ds_list_find_value(line_place, i)) == noone && test_dist_xneg < 3) {
					test_dist_xneg += 0.2;
				} 
				while (instance_place(x, y + test_dist_ypos, ds_list_find_value(line_place, i)) == noone && test_dist_ypos < 3) {
					test_dist_ypos += 0.2;
				} 					
				while (instance_place(x, y + test_dist_yneg, ds_list_find_value(line_place, i)) == noone && test_dist_yneg < 3) {
					test_dist_yneg += 0.2;
				} 

                move = min(test_dist_xpos, test_dist_xneg, test_dist_ypos, test_dist_yneg);
                        
                if (move < 3) 
                    if (move == test_dist_xpos) {
                        x += test_dist_xpos; 
						xprevious = x;
                                
                        if (first_move == 0) { 
							first_move = 1; 
						}
                        last_move_last = last_move; 
						last_move = 1;
                    } else if (move == test_dist_xneg) {
                        x -= test_dist_xneg; 
						xprevious = x;
                                
                        if (first_move == 0) { 
							first_move = 2; 
						}
                        last_move_last = last_move; 
						last_move = 2;
                    } else if (move == test_dist_ypos) {
                        y += test_dist_ypos; 
						yprevious = y;
                                
                        if (first_move == 0) { 
							first_move = 3; 
						}
                        last_move_last = last_move; 
						last_move = 3;
                    } else if (move == test_dist_yneg) {
                        y -= test_dist_yneg; 
						yprevious = y;
                                
                        if (first_move == 0) { 
							first_move = 4; 
						}
                        last_move_last = last_move; 
						last_move = 4;
                    }
                } else {
                    x = x_back; 
					y = y_back;
                    yprevious = y_back; 
					xprevious = x_back;
                    last_move = last_move_last;
                }
            }
			
            if (instance_place_check(x, y, objBlock, tangible) == noone) {
				for (var i = 0; i < line_place; i++) {
		            test_dist_xpos = 0;
		            test_dist_ypos = 0;
		            test_dist_xneg = 0;
		            test_dist_yneg = 0;
                    
					while (instance_place(x + test_dist_xpos, y, ds_list_find_value(line_place, i)) == noone && test_dist_xpos < 3) {
						test_dist_xpos += 0.2;
					} 
					while (instance_place(x - test_dist_xneg, y, ds_list_find_value(line_place, i)) == noone && test_dist_xneg < 3) {
						test_dist_xneg += 0.2;
					} 
					while (instance_place(x, y + test_dist_ypos, ds_list_find_value(line_place, i)) == noone && test_dist_ypos < 3) {
						test_dist_ypos += 0.2;
					} 					
					while (instance_place(x, y + test_dist_yneg, ds_list_find_value(line_place, i)) == noone && test_dist_yneg < 3) {
						test_dist_yneg += 0.2;
					} 
                        
		            move = min(test_dist_xpos, test_dist_xneg, test_dist_ypos, test_dist_yneg);
                    
		            if (move == test_dist_xpos) {
		                x += test_dist_xpos;
						xprevious = x;
                        
		                if (first_move == 0) {
							first_move = 1; 
						}
		                last_move_last = last_move; 
						last_move = 1;
		            } else if (move == test_dist_xneg) {
		                x -= test_dist_xneg; 
						xprevious = x;
                        
		                if (first_move == 0) { 
							first_move = 2; 
						}
		                last_move_last = last_move; 
						last_move = 2;
		            } else if (move == test_dist_ypos) {
		                y += test_dist_ypos; 
						yprevious = y;
                        
		                if (first_move == 0) { 
							first_move = 3; 
						}
		                last_move_last = last_move; 
						last_move = 3;
		            } else if (move == test_dist_yneg) {
		                y -= test_dist_yneg; 
						yprevious = y;
                        
		                if (first_move == 0) { 
							first_move = 4; 
						}
		                last_move_last = last_move; 
						last_move = 4;
		            }
		        }
			}
			ds_list_destroy(list);
        }
        blah = 1;
    }
	#endregion
} else {
	image_angle = 0;	
}
#endregion

if (!global.forms.lunarkid) {
	#region Movement Checks
	//If the player is frozen no movement is applied
	if (!frozen) {
		if (dir_right || dir_left) {
			dir = (dir_right) ? 1 : -1; 
		}
	}
	
	on_block = instance_place_check(x, y + global.grav, objBlock, tangible);
	var on_vineR = (place_meeting(x - 1, y, objVineR) && on_block == noone);
	var on_vineL = (place_meeting(x + 1, y, objVineL) && on_block == noone);
	#endregion
	
	#region Horizontal Movement
	if (dir != 0) {
		if (!on_vineR && !on_vineL) {
			xscale = dir;
		}
	
		if ((dir == 1 && !on_vineR) || (dir == -1 && !on_vineL)) {
			hspd = max_hspd * dir;
			player_sprite(PLAYER_ACTIONS.RUN);
		}
	} else {
		hspd = 0;
		player_sprite(PLAYER_ACTIONS.IDLE);
	}
	#endregion

	#region Vertical Movement
	if (vspd * global.grav < -0.05) {
	    player_sprite(PLAYER_ACTIONS.JUMP);
	} else if (vspd * global.grav > 0.05) {
	    player_sprite(PLAYER_ACTIONS.FALL);
	}

	if (abs(vspd) > max_vspd) {
		vspd = max_vspd * sign(vspd);
	}
	#endregion

	#region Player Actions
	if (!frozen) {
		#region Controls
		if (is_pressed(global.controls.jump)) {
			player_jump();
		}
	
		if (is_released(global.controls.jump)) {
			player_fall();
		}
		#endregion
	
	    #region Ladders
	    if (dir_up || dir_down) {
	        if (!on_ladder && instance_place_check(x, y, objLadder, tangible) != noone) {
	            on_ladder = true;
	            reset_jumps();
	        }
	    }
    
	    if (on_ladder) {
	        if (instance_place_check(x, y, objLadder, tangible) == noone) {
	            on_ladder = false;
	        } else {
	            grav = 0;
	            hspd = 0;
	            vspd = 0;
	            player_sprite(PLAYER_ACTIONS.CLIMB);
            
	            if (dir_up || dir_down) {
	                y -= (dir_up) ? max_hspd : -max_hspd;
	                player_sprite(PLAYER_ACTIONS.CLIMB_VERTICAL);
	            } 
	            if (dir_right || dir_left) {
	                x += (dir_right) ? max_hspd : -max_hspd;
	                player_sprite(PLAYER_ACTIONS.CLIMB_HORIZONTAL);
	            }
	        }
	    }
	    #endregion
	
		#region Vines
		if (on_vineR || on_vineL) {
			xscale = (on_vineR) ? 1 : -1;
		    vspd = 2 * global.grav;
		    player_sprite(PLAYER_ACTIONS.SLIDE);
    
		    if ((on_vineR && is_pressed(global.controls.right)) || (on_vineL && is_pressed(global.controls.left))) {
		        if (is_held(global.controls.jump)) {
		            hspd = (on_vineR) ? 15 : -15;
		            vspd = -9 * global.grav;
		            player_sprite(PLAYER_ACTIONS.JUMP);
					audio_play_sound(sndVine, 0, false);
		        } else {
		            hspd = (on_vineR) ? 3 : -3;
		            player_sprite(PLAYER_ACTIONS.FALL);
		        }
		    }
		}
		#endregion
	
		#region Debug
		if (global.debug_enable && on_block) {
			dir = (is_pressed(global.controls_debug.alignR) - is_pressed(global.controls_debug.alignL));
		
			if (dir != 0) {
				hspd = dir;
			}
		}
		#endregion
	}
	#endregion
}

if (is_pressed(global.controls.shoot)) {
	player_shoot();
}

#region Physics and Collision
//Storing the previous x and y
xprevious = x;
yprevious = y;

//Moving the player manually
vspd += grav;
x += hspd;
y += vspd;

#region Collision with block
var block = instance_place_check(x, y, objBlock, tangible);

if (block != noone) {
	x = xprevious;
	y = yprevious;
	
	if (global.forms.lunarkid) {
		kill_player();
	} else {
		//Detect horizontal collision
		if (instance_place_check(x + hspd, y, objBlock, tangible) != noone) {
			while (instance_place_check(x + sign(hspd), y, objBlock, tangible) = noone) {
				x += sign(hspd);
			}
	
			hspd = 0;
		}

		//Detect vertical collision
		if (instance_place_check(x, y + vspd, objBlock, tangible) != noone) {
			while (instance_place_check(x, y + sign(vspd), objBlock, tangible) == noone) {
				y += sign(vspd);
			}
	
			if (vspd * global.grav > 0) {
				reset_jumps();
			}
	
			vspd = 0;
			grav = 0;
		}

		//Detect diagonal collision
		if (instance_place_check(x + hspd, y + vspd, objBlock, tangible) != noone) {
			hspd = 0;
		}

		x += hspd;
		y += vspd;
	
		//Makes player move based on the block speed
		if (instance_place_check(x + block.hspd, y, objBlock, tangible) == noone) {
			x += block.hspd;
		}
	
		if (instance_place_check(x, y + block.vspd, objBlock, tangible) == noone) {
			y += block.vspd;
		}
	}
}
#endregion

#region Collision with platform
	if (vspd * global.grav >= 0) {
		var platform = instance_place(x, y, objPlatform);
	
		if (platform != noone) {
			if (global.grav == 1) {
				var bbox_check = (bbox_bottom - max(1, abs(vspd)) <= platform.bbox_top + 1);
			} else {
				var bbox_check = (bbox_top + max(1, abs(vspd)) >= platform.bbox_bottom - 1);
			}

			if (bbox_check) {
				y = yprevious;
			
				//Detect vertical collision
				if (place_meeting(x, y + vspd, objPlatform)) {
					while (!place_meeting(x, y + sign(vspd), objPlatform)) {
						y += sign(vspd);
					}

					vspd = 0;
					grav = 0;
					reset_jumps();
				}
	
				y += vspd;
		
				//Makes player move based on the platform speed
				if (!place_meeting(x + platform.hspd, y, objBlock)) {
					x += platform.hspd;
				}
	
				if (!place_meeting(x, y + platform.vspd, objBlock)) {
					y += platform.vspd;
				}
			}
		}
	}
	#endregion
	
#endregion