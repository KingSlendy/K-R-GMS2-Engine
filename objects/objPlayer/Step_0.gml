#region Variable and Input Checks
if (place_meeting(x, y, objFieldAntiGrav) || grav_mod.anti) { 
	grav = -grav_amount * global.grav;
} else {
	grav = grav_amount * global.grav;
}

var dir_left = is_held(global.controls.left);
var dir_right = is_held(global.controls.right);
var dir_down = is_held(global.controls.down);
var dir_up = is_held(global.controls.up);
var dir = 0;

var tangible = function(obj) { return (obj.image_alpha == 1); }
if (instance_place_check(x, y, objWeirdWater, tangible) != noone && hspd != 0) {
	frozen = true;
	water_mod.weird = true;
} else {
	if (water_mod.weird) {
		frozen = false;
	}
}

if (collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, objPoisonWater, 0, 0)) {
    poison_time = approach(poison_time, 0, 1);
    if (poison_time == 0) {
        kill_player();
	}
} else if (poison_time != max_poison) {
    poison_time = max_poison;
}

frozen = (instance_place_check(x, y, objWeirdWater, tangible) != noone && hspd != 0);

#endregion

#region Transformations        
global.player.angle = image_angle;

if (global.forms.lunarkid) { //Lunar Lander, aka "Rocket"
	#region Lunarkid functionality
	if (is_pressed(global.controls.jump) && global.forms.vkid > 0) {
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
    player_sprite(PLAYER_ACTIONS.LUNARKID);
	#endregion
} else { 
	if (global.forms.linekid) {
		#region Linekid functionality
		if (dir_up || dir_down) {
			if (((global.player.angle > 0 && global.player.angle <= 90) || (global.player.angle > 180 && global.player.angle <= 270) 
			&& instance_place_check(x - 2, y, objBlock, tangible) == noone || instance_place_check(x + 2, y, objBlock, tangible) == noone)
			|| instance_place_check(x, y - 2, objBlock, tangible) == noone || instance_place_check(x, y + 2, objBlock, tangible) == noone) {
				image_angle = (image_angle + (dir_up - dir_down) * 3) % 360;
			}
		}
        
	    if (on_block != noone && instance_place_check(x, y, objBlock, tangible) == noone) {	
			while (instance_place_check(x, y + test_dist.orig + 0.05, objBlock, tangible) == noone && test_dist.orig < 2) {
				test_dist.orig += 0.05;

				if (test_dist.orig < 2) { 
					y += test_dist.orig; 
				}
			}
        
			var first_move = 0;
			var last_move_last = 0;
			var x_back = x; 
			var y_back = y;
			var blah = false;
			var last_move = 0;
		
			var list = ds_list_create();
			var line_place = instance_place_list(x, y, objBlock, list, false); 
		
			for (var i = 0; i < line_place; i++) {
				var curr_line_place = line_place[| i];
			
				if (curr_line_place.image_alpha == 1) {
					test_dist.xpos = 0;
					test_dist.ypos = 0;
					test_dist.xneg = 0;
					test_dist.yneg = 0;
						
					if (blah) {
						if (first_move == 1) { 
							test_dist.xpos = 99; 
						} else if (first_move == 2) { 
							test_dist.xneg = 99; 
						} else if (first_move == 3) { 
							test_dist.ypos = 99; 
						} else if (first_move == 4) { 
							test_dist.yneg = 99; 
						}
					}
					
					if (last_move == 1) { 
						test_dist.xneg = 99; 
					} else if (last_move == 2) { 
						test_dist.xpos = 99; 
					} else if (last_move == 3) { 
						test_dist.yneg = 99; 
					} else if (last_move == 4) { 
						test_dist.ypos = 99; 
					}
						
					while (instance_place(x + test_dist.xpos, y, curr_line_place) != noone && test_dist.xpos < 3) {
						test_dist.xpos += 0.2;
					}
				
					while (instance_place(x - test_dist.xneg, y, curr_line_place) != noone && test_dist.xneg < 3) {
						test_dist.xneg += 0.2;
					}
				
					while (instance_place(x, y + test_dist.ypos, curr_line_place) != noone && test_dist.ypos < 3) {
						test_dist.ypos += 0.2;
					}
				
					while (instance_place(x, y - test_dist.yneg, curr_line_place) != noone && test_dist.yneg < 3) {
						test_dist.yneg += 0.2;
					}

					var move = min(test_dist.xpos, test_dist.xneg, test_dist.ypos, test_dist.yneg);
					
					if (move < 3) {
						if (move == test_dist.xpos) {
							x += test_dist.xpos; 
							xprevious = x;
								
							if (first_move == 0) { 
								first_move = 1; 
							}
						
							last_move_last = last_move; 
							last_move = 1;
						} else if (move == test_dist.xneg) {
							x -= test_dist.xneg; 
							xprevious = x;
								
							if (first_move == 0) { 
								first_move = 2; 
							}
						
							last_move_last = last_move; 
							last_move = 2;
						} else if (move == test_dist.ypos) {
							y += test_dist.ypos; 
							yprevious = y;
								
							if (first_move == 0) { 
								first_move = 3; 
							}
						
							last_move_last = last_move; 
							last_move = 3;
						} else if (move == test_dist.yneg) {
							y -= test_dist.yneg; 
							yprevious = y;
								
							if (first_move == 0) { 
								first_move = 4; 
							}
						
							last_move_last = last_move; 
							last_move = 4;
						}
					}
				} else {
					x = x_back; 
					y = y_back;
					yprevious = y_back; 
					xprevious = x_back;
					last_move = last_move_last;
				}
			}
		
			if (instance_place_check(x, y, objBlock, tangible) != noone) {
				for (var i = 0; i < line_place; i++) {
					var curr_line_place = line_place[| i];
					test_dist.xpos = 0;
					test_dist.ypos = 0;
					test_dist.xneg = 0;
					test_dist.yneg = 0;
				
					while (instance_place(x + test_dist.xpos, y, curr_line_place) != noone && test_dist.xpos < 3) {
						test_dist.xpos += 0.2;
					}
				
					while (instance_place(x - test_dist.xneg, y, curr_line_place) != noone && test_dist.xneg < 3) {
						test_dist.xneg += 0.2;
					}
				
					while (instance_place(x, y + test_dist.ypos, curr_line_place) != noone && test_dist.ypos < 3) {
						test_dist.ypos += 0.2;
					}
				
					while (instance_place(x, y - test_dist.yneg, curr_line_place) != noone && test_dist.yneg < 3) {
						test_dist.yneg += 0.2;
					}
					
					var move = min(test_dist.xpos, test_dist.xneg, test_dist.ypos, test_dist.yneg);
				
					if (move == test_dist.xpos) {
						x += test_dist.xpos;
						xprevious = x;
					
						if (first_move == 0) {
							first_move = 1; 
						}
					
						last_move_last = last_move; 
						last_move = 1;
					} else if (move == test_dist.xneg) {
						x -= test_dist.xneg; 
						xprevious = x;
					
						if (first_move == 0) { 
							first_move = 2; 
						}
					
						last_move_last = last_move; 
						last_move = 2;
					} else if (move == test_dist.ypos) {
						y += test_dist.ypos; 
						yprevious = y;
					
						if (first_move == 0) { 
							first_move = 3; 
						}
					
						last_move_last = last_move; 
						last_move = 3;
					} else if (move == test_dist.yneg) {
						y -= test_dist.yneg; 
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
	        blah = true;
	    }
		#endregion
	} else {
		image_angle = 0;	
	}
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
	
	on_ice = {
		block: instance_place_check(x, y + global.grav, objSlipBlock, tangible), 
		water: instance_place_check(x, y, objIceWater, tangible)
	};
	
	on_slide = {
		block: instance_place_check(x, y + global.grav, objSlideBlock, tangible), 
		water: instance_place_check(x, y, objConveyorWater, tangible)
	};
	
	#region Vine Checks
	var vine_off = 1;
	if (global.forms.linekid) {
		vine_off = 2;
	}
	
	var on_vineR = (place_meeting(x - vine_off, y, objVineR) && on_block == noone);
	var on_vineL = (place_meeting(x + vine_off, y, objVineL) && on_block == noone);
	#endregion
	
	#region Speed Checks
	if (place_meeting(x, y, objFieldFastSpeed) || spd_mod.fast || jump_mod.fast == 2) {
		max_hspd = 6;
	} else if (place_meeting(x, y, objFieldSlowSpeed) || spd_mod.slow) {
		max_hspd = 1;
	} else {
		max_hspd = 3;
	}
	#endregion
	
	#region Gravity Checks
    if (place_meeting(x, y, objFieldHighGrav) || grav_mod.high) {
        grav_amount = 0.7;
    } else if (place_meeting(x, y, objFieldLowGrav) || grav_mod.low) {
		grav_amount = 0.2;
    } else if ((place_meeting(x, y, objFieldZeroGrav) || grav_mod.zero || vine_mod.zerograv) || vine_mod.stick) {
        grav_amount = 0;
		vine_mod.stick = false;
    } else if (vine_mod.lowgrav) {
        grav_amount = 0.3;
    } else if (instance_place_check(x, y, objPlatformWater, tangible) == noone) {
		grav_amount = 0.4;
		water_mod.platform = false;
	}
        
	gravity_direction = (abs(global.grav) == 2) ? 0 : 270;
	#endregion
	
	#region Jump Checks
	if (jump_mod.high == 1) {
		jump_height[1] = 12;
	} else if (jump_mod.low == 1) {
		jump_height[1] = 5;
	} else {
		jump_height[1] = 7;
	}
	
	if (on_block || on_platform) {
		struct_set_all(jump_mod, 0);
		if (instance_exists(objSlowmoJumpEffect)) {
			instance_destroy(objSlowmoJumpEffect);
		}
	}
	#endregion
	
	#endregion
	
	#region Horizontal Movement
	function gun_accelerate() {
		if (is_pressed(global.controls.shoot)) {
			hspd = -(max_hspd * 2) * xscale;
		}
		hspd = approach(hspd, 0, 0.1);
	}
	
	if (dir != 0) {
		if (!on_vineR && !on_vineL) {
			xscale = dir;
		}
	
		if ((dir == 1 && !on_vineR) || (dir == -1 && !on_vineL)) {
			if (instance_place_check(x, y, objGunWater, tangible) == noone) {
				if (on_ice == noone) {
					hspd = max_hspd * dir;
				} else {
					#region Ice Movement
					hspd += on_ice.slip * dir;
					if (on_ice.block != noone) {
						if (abs(hspd) > max_hspd) {
							hspd = max_hspd * dir;
						}
					}
					if (on_ice.water != noone) {
						if (abs(hspd) > max_hspd * 1.5) {
							hspd = (max_hspd * 1.5) * dir;
						}
					}
					if (on_ice.water.object_index == objWeirdWater && hspd == 0) {
						hspd = max_hspd * dir;
					}
					#endregion
				}
				player_sprite(PLAYER_ACTIONS.RUN);
			} else {
				gun_accelerate();
			}
		}
	} else {
		if (instance_place_check(x, y, objGunWater, tangible) == noone) {
			if (on_ice == noone) {
				hspd = 0;
			} else {
				hspd = approach(hspd, 0, on_ice.slip);
			}
		} else {
			gun_accelerate();
		}
		player_sprite(PLAYER_ACTIONS.IDLE);
	}
	#endregion

	#region Vertical Movement
	if (!on_platform) {
		if (vspd * global.grav < -0.05) {
		    player_sprite(PLAYER_ACTIONS.JUMP);
		} else if (vspd * global.grav > 0.05) {
		    player_sprite(PLAYER_ACTIONS.FALL);
		}
	} else {
		if (!place_meeting(x, y + (4 * global.grav), objPlatform)) {
			on_platform = false;
		}
	}

	if (vspd * global.grav > max_vspd) {
		vspd = max_vspd * sign(vspd);
	}
	#endregion

	#region General Movement
        if (on_slide != noone) { //on a slide block, start moving with it
			if (on_slide.hspd != 0) {
				hspd += on_slide.hspd; 
			}
			if (on_slide && on_slide.vspd != 0) {
				vspd += on_slide.vspd;
				if (instance_place_check(x, y - vspd * global.grav, objBlock, tangible) == noone) {
					if (vspd * global.grav <= 0) {
						player_sprite(PLAYER_ACTIONS.JUMP);
					} else if (vspd * global.grav > 0) {
						player_sprite(PLAYER_ACTIONS.FALL);
					}
				}
			}
		}
	#endregion

	#region Player Actions
	if (!frozen || instance_place_check(x, y, objWeirdWater, tangible) != noone) {
		#region Controls
		if (is_pressed(global.controls.jump)) {
			player_jump();
		}
	
		if (is_released(global.controls.jump)) {
			player_fall();
		}
		#endregion

		if (instance_place_check(x, y, objWeirdWater, tangible) == noone) {
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
						if (instance_place_check(x, y - ((dir_up - dir_down) * max_hspd), objBlock, tangible) == noone) {
							y -= (dir_up) ? max_hspd : -max_hspd;
						} 
						player_sprite(PLAYER_ACTIONS.CLIMB_VERTICAL);
		            } 
				
		            if (dir_right || dir_left) {
						if (instance_place_check(x + ((dir_right - dir_left) * max_hspd), y, objBlock, tangible) == noone) {
							x += (dir_right) ? max_hspd : -max_hspd;
						}
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
var block_place = instance_place_check(x, y, objBlock, tangible);

if (block_place != noone) {
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
		if (instance_place_check(x + block.hspeed, y, objBlock, tangible) == noone) {
			x += block.hspeed;
		}
	
		if (instance_place_check(x, y + block.vspeed, objBlock, tangible) == noone) {
			y += block.vspeed;
		}
	}
}
#endregion

#region New collision with platform
	/*if (vspd * global.grav >= 0) {
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
	}*/
#endregion
#endregion