#region Variable and Input Checks
var grav_factor = (place_meeting(x, y, objFieldAntiGrav)) ? -1 : 1;
grav = (vine_mod.stick) ? 0 : (grav_amount * grav_factor) * sign(global.grav);
gravity_direction = (abs(global.grav) == 1) ? 270 : 0;

var left = null;
var right = null;
var down = null;
var up = null;
var dir = 0;

var directions = control_gravity(
	global.controls.left, 
	global.controls.right,
	global.controls.down,
	global.controls.up
);
left = directions.left_direction;
right = directions.right_direction;
down = global.controls.down;
up = global.controls.up;
    
var dir_left = is_buffered(left);
var dir_right = is_buffered(right);
var dir_down = is_held(down);
var dir_up = is_held(up);

package_fieldsNANG("player prestep");
package_vineventure("player prestep");
package_wetventure("player prestep");
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
		#region Linekid original "Step" code that's a fucking mess
        /*if((scrButtonCheck(global.alignLeftButton) || scrButtonCheck(global.upButton)) 
        || (scrButtonCheck(global.alignRightButton) || scrButtonCheck(global.downButton))){
            if(scrButtonCheck(global.alignLeftButton) || scrButtonCheck(global.upButton)){
                if((image_angle >= 0 && image_angle < 90) || (image_angle >= 180 && image_angle < 270)){
                    if(place_free(x-2, y) || place_free(x+2, y)){
                        image_angle += 3
                        if(image_angle > 360 || image_angle < 0){
                            image_angle = (image_angle+360) mod 360
                        }
                    }
                }
                else if(place_free(x, y-2) || place_free(x, y+2)){
                    image_angle += 3
                    if(image_angle > 360 || image_angle < 0){
                        image_angle = (image_angle+360) mod 360
                    }
                }
            }
            if(scrButtonCheck(global.alignRightButton) || scrButtonCheck(global.downButton)){
                if((image_angle > 0 && image_angle <= 90) || (image_angle > 180 && image_angle <= 270)){
                    if(place_free(x, y-2) || place_free(x, y+2)){
                        image_angle -= 3
                        if(image_angle > 360 || image_angle < 0){
                            image_angle = (image_angle+360) mod 360
                        }
                    }
                }
                else if(place_free(x-2, y) || place_free(x+2, y)){
                    image_angle -= 3
                    if(image_angle > 360 || image_angle < 0){
                        image_angle = (image_angle+360) mod 360
                    }
                }
            }
        }
        
        if(!notOnBlock){
            if(place_free(x, y)){
                testDist = 0
                while(place_free(x,y+testDist+.05) && testDist < 2){
                    testDist += .05
                }
                if(testDist < 2){
                    y += testDist
                }
            }
        }
        firstMove = 0
        lastMoveLast = 0
        xBack = x
        yBack = y
        blah = false
        while(!place_free(x, y) || place_meeting(x, y, objBlock)){
            lastMove = 0
            lineCollisionList = scrInstancePlaceList(x, y, objBlock)
            if(lineCollisionList != noone){
                num = ds_list_size(lineCollisionList)
                for(i = 0; i < num; i++){
                    if(ds_list_find_value(lineCollisionList, i).solid){
                        testDistXpos = 0
                        testDistYpos = 0
                        testDistXneg = 0
                        testDistYneg = 0
                        
                        if(blah){
                            if(firstMove = 1){
                                testDistXpos = 99
                            }
                            else if(firstMove = 2){
                                testDistXneg = 99
                            }
                            else if(firstMove = 3){
                                testDistYpos = 99
                            }
                            else if(firstMove = 4){
                                testDistYneg = 99
                            }
                        }
                        
                        if(lastMove = 1){
                            testDistXneg = 99
                        }
                        else if(lastMove = 2){
                            testDistXpos = 99
                        }
                        else if(lastMove = 3){
                            testDistYneg = 99
                        }
                        else if(lastMove = 4){
                            testDistYpos = 99
                        }
                        
                        while(place_meeting(x+testDistXpos, y, ds_list_find_value(lineCollisionList, i)) && testDistXpos < 3){
                            testDistXpos += .2
                        }
                        while(place_meeting(x-testDistXneg, y, ds_list_find_value(lineCollisionList, i)) && testDistXneg < 3){
                            testDistXneg += .2
                        }
                        while(place_meeting(x, y+testDistYpos, ds_list_find_value(lineCollisionList, i)) && testDistYpos < 3){
                            testDistYpos += .2
                        }
                        while(place_meeting(x, y-testDistYneg, ds_list_find_value(lineCollisionList, i)) && testDistYneg < 3){
                            testDistYneg += .2
                        }
                        
                        move = min(testDistXpos, testDistXneg, testDistYpos, testDistYneg)
                        if(move < 3){
                            if(move == testDistXpos){
                                    x += testDistXpos
                                    xprevious = x
                                    if(firstMove = 0){
                                        firstMove = 1
                                    }
                                    lastMoveLast = lastMove
                                    lastMove = 1
                                }
                            else if(move == testDistXneg){
                                    x -= testDistXneg
                                    xprevious = x
                                    if(firstMove = 0){
                                        firstMove = 2
                                    }
                                    lastMoveLast = lastMove
                                    lastMove = 2
                                }
                            else if(move == testDistYpos){
                                    y += testDistYpos
                                    yprevious = y
                                    if(firstMove = 0){
                                        firstMove = 3
                                    }
                                    lastMoveLast = lastMove
                                    lastMove = 3
                            }
                            else if(move == testDistYneg){
                                    y -= testDistYneg
                                    yprevious = y
                                    if(firstMove = 0){
                                        firstMove = 4
                                    }
                                    lastMoveLast = lastMove
                                    lastMove = 4
                            }
                        }
                        else{
                            x = xBack
                            y = yBack
                            yprevious = yBack
                            xprevious = xBack
                            lastMove = lastMoveLast
                        }
                    }
                }
                if(!place_free(x, y)){
                    testDistXpos = 0
                    testDistYpos = 0
                    testDistXneg = 0
                    testDistYneg = 0
                    
                    while(!place_free(x+testDistXpos, y) && testDistXpos < 3){
                        testDistXpos += .2
                    }
                    while(!place_free(x-testDistXneg, y) && testDistXneg < 3){
                        testDistXneg += .2
                    }
                    while(!place_free(x, y+testDistYpos) && testDistYpos < 3){
                        testDistYpos += .2
                    }
                    while(!place_free(x, y-testDistYneg) && testDistYneg < 3){
                        testDistYneg += .2
                    }
                    
                    move = min(testDistXpos, testDistXneg, testDistYpos, testDistYneg)
                    if(move == testDistXpos){
                            x += testDistXpos
                            xprevious = x
                            if(firstMove = 0){
                                firstMove = 1
                            }
                            lastMoveLast = lastMove
                            lastMove = 1
                        }
                    else if(move == testDistXneg){
                            x -= testDistXneg
                            xprevious = x
                            if(firstMove = 0){
                                firstMove = 2
                            }
                            lastMoveLast = lastMove
                            lastMove = 2
                        }
                    else if(move == testDistYpos){
                            y += testDistYpos
                            yprevious = y
                            if(firstMove = 0){
                                firstMove = 3
                            }
                            lastMoveLast = lastMove
                            lastMove = 3
                    }
                    else if(move == testDistYneg){
                            y -= testDistYneg
                            yprevious = y
                            if(firstMove = 0){
                                firstMove = 4
                            }
                            lastMoveLast = lastMove
                            lastMove = 4
                    }
                }
            }
            blah = true
        }*/
		#endregion
		
		#region Linekid original "Collision with ObjBlock" code that's SUPER messy
		/*if(!global.lunarLander){
		    if(other.solid){
		        if(global.threeDmove){
		            collisionList = scrInstancePlaceList(x, y, objBlock)
		            if(collisionList != noone){
		                num = ds_list_size(collisionList)
		                for(i = 0; i < num; i++){
		                    if(ds_list_find_value(collisionList, i).solid){
		                        testDistXpos = 0
		                        testDistYpos = 0
		                        testDistXneg = 0
		                        testDistYneg = 0
		                        
		                        while(place_meeting(x+testDistXpos, y, ds_list_find_value(collisionList, i)) && testDistXpos < 2){
		                            testDistXpos += .01  
		                        }
		                        while(place_meeting(x-testDistXneg, y, ds_list_find_value(collisionList, i)) && testDistXneg < 2){
		                            testDistXneg += .01  
		                        }
		                        while(place_meeting(x, y+testDistYpos, ds_list_find_value(collisionList, i)) && testDistYpos < 2){
		                            testDistYpos += .01  
		                        }
		                        while(place_meeting(x, y-testDistYneg, ds_list_find_value(collisionList, i)) && testDistYneg < 2){
		                            testDistYneg += .01  
		                        }
		                    
		                        move = min(testDistXpos, testDistXneg, testDistYpos, testDistYneg)
		                        
		                        if(move == testDistXpos){
		                            x += testDistXpos    
		                        }
		                        else if(move == testDistXneg){
		                            x -= testDistXneg
		                        }
		                        else if(move == testDistYpos){
		                            y += testDistYpos
		                        }
		                        else if(move == testDistYneg){
		                            y -= testDistYneg
		                        }
		                    }
		                }
		            }
		            
		            if(!notOnBlock){
		                testDist = 0
		                while(!place_meeting(x,y+testDist+.01, objBlock) && testDist < 2){
		                    testDist += .01
		                }
		                if(testDist < 2){
		                    y += testDist
		                }
		            }
		        }
		        
		        //show_debug_message(string(fps_real) + " collision");
		        with(objPushBlock){
		            x = xMoved
		            y = yMoved
		        }
		        
		        if (place_meeting(x+hspeed,y, objBlock) && !place_free(x+hspeed, y))
		        {
		            if (sign(global.grav) == 1)   //normal
		            {
		                if(hspeed <= 0){move_contact_solid(180,abs(hspeed));if(other.object_index = objLifeblockv2){instance_create(other.x, other.y, objNoiseMaker);}}
		                if(hspeed > 0){move_contact_solid(0,abs(hspeed));if(global.xGrav) djump = 1;if(other.object_index = objLifeblockv2){instance_create(other.x, other.y, objNoiseMaker);}}
		            }
		            else    //flipped
		            {
		                if(hspeed < 0){move_contact_solid(180,abs(hspeed));if(global.xGrav) djump = 1;if(other.object_index = objLifeblockv2){instance_create(other.x, other.y, objNoiseMaker);}}
		                if(hspeed >= 0){move_contact_solid(0,abs(hspeed));if(other.object_index = objLifeblockv2){instance_create(other.x, other.y, objNoiseMaker);}}
		            }
		            hspeed = 0;
		        }
		         
		        if(!global.linekid || !(place_free(x+.6, y+vspeed) || place_free(x-.6, y+vspeed))){
		            if (place_meeting(x,y+vspeed, objBlock) && !place_free(x, y+vspeed))
		            {
		                if (sign(global.grav) == 1)   //normal
		                {
		                    if(vspeed <= 0){move_contact_solid(90,abs(vspeed));if(other.object_index = objLifeblockv2){instance_create(other.x, other.y, objNoiseMaker);}}
		                    if(vspeed > 0){move_contact_solid(270,abs(vspeed));if(!global.xGrav) djump = 1; if(other.object_index = objLifeblockv2){instance_create(other.x, other.y, objNoiseMaker);}}
		                }
		                else    //flipped
		                {
		                    if(vspeed <= 0){move_contact_solid(90,abs(vspeed));if(!global.xGrav) djump = 1; if(other.object_index = objLifeblockv2){instance_create(other.x, other.y, objNoiseMaker);}}
		                    if(vspeed > 0){move_contact_solid(270,abs(vspeed));if(other.object_index = objLifeblockv2){instance_create(other.x, other.y, objNoiseMaker);}}
		                }
		                vspeed = 0;
		            }
		        }
		        else if(global.linekid && notOnBlock){
		            if(place_free(x+.6, y+vspeed)){
		                x += .6
		            }
		            else{
		                x -= .6
		            }
		        }
		        
		        if(place_meeting(x+hspeed,y+vspeed, objBlock) && !place_free(x+hspeed, y+vspeed)){
		            var xTest = x;
		            var yTest = y;
		            
		            while(true){
		                xTest += hspeed/10
		                if(place_meeting(xTest, yTest, objBlock)){
		                    var yTemp = y
		                    y = yTest
		                    if (sign(global.grav) == 1)   //normal
		                    {
		                        if(hspeed <= 0){move_contact_solid(180,abs(hspeed));if(other.object_index = objLifeblockv2){instance_create(other.x, other.y, objNoiseMaker);}}
		                        if(hspeed > 0){move_contact_solid(0,abs(hspeed));if(global.xGrav) djump = 1;if(other.object_index = objLifeblockv2){instance_create(other.x, other.y, objNoiseMaker);}}
		                    }
		                    else    //flipped
		                    {
		                        if(hspeed < 0){move_contact_solid(180,abs(hspeed));if(global.xGrav) djump = 1;if(other.object_index = objLifeblockv2){instance_create(other.x, other.y, objNoiseMaker);}}
		                        if(hspeed >= 0){move_contact_solid(0,abs(hspeed));if(other.object_index = objLifeblockv2){instance_create(other.x, other.y, objNoiseMaker);}}
		                    }
		                    hspeed = 0;
		                    y = yTemp
		                    break;
		                }
		                yTest += vspeed/10
		                if(place_meeting(xTest, yTest, objBlock)){
		                    var xTemp = x
		                    x = xTest
		                    if (sign(global.grav) == 1)   //normal
		                    {
		                        if(vspeed <= 0){move_contact_solid(90,abs(vspeed));if(other.object_index = objLifeblockv2){instance_create(other.x, other.y, objNoiseMaker);}}
		                        if(vspeed > 0){move_contact_solid(270,abs(vspeed));if(!global.xGrav) djump = 1; if(other.object_index = objLifeblockv2){instance_create(other.x, other.y, objNoiseMaker);}}
		                    }
		                    else    //flipped
		                    {
		                        if(vspeed <= 0){move_contact_solid(90,abs(vspeed));if(!global.xGrav) djump = 1; if(other.object_index = objLifeblockv2){instance_create(other.x, other.y, objNoiseMaker);}}
		                        if(vspeed > 0){move_contact_solid(270,abs(vspeed));if(other.object_index = objLifeblockv2){instance_create(other.x, other.y, objNoiseMaker);}}
		                    }
		                    vspeed = 0;
		                    x = xTemp
		                    break;
		                }
		            }
		        }
		    }
		}
		else{
		    scrKillPlayer()
		}
		
		if (!global.linekid || !(place_free(x + 0.6, y + vspeed) || place_free(x - 0.6, y + vspeed))) {
			    if (place_meeting(x,y + vspeed, objBlock) && !place_free(x, y + vspeed)) {
			        if (sign(global.grav) == 1) {
			            if(vspeed <= 0){move_contact_solid(90,abs(vspeed));}
			            if(vspeed > 0){move_contact_solid(270,abs(vspeed));}
			        } else {
			            if(vspeed <= 0){move_contact_solid(90,abs(vspeed));}
			            if(vspeed > 0){move_contact_solid(270,abs(vspeed));}
			        }
			        vspeed = 0;
			    }
			} else if (global.linekid && notOnBlock) {
			    if (place_free(x + 0.6, y + vspeed)) {
			        x += 0.6;
			    } else {
			        x -= 0.6;
			    }
			}
		}
		
		if (place_meeting(x + hspeed, y + vspeed, objBlock) && !place_free(x + hspeed, y + vspeed)) {
		    var xTest = x;
		    var yTest = y;
		    
		    while(true) {
		        xTest += hspeed / 10;
		        if (place_meeting(xTest, yTest, objBlock)) {
		            var yTemp = y;
		            y = yTest;
		            if (sign(global.grav) == 1) {
		                if(hspeed <= 0){move_contact_solid(180,abs(hspeed));}
		                if(hspeed > 0){move_contact_solid(0,abs(hspeed));}
		            } else {
		                if(hspeed < 0){move_contact_solid(180,abs(hspeed));}
		                if(hspeed >= 0){move_contact_solid(0,abs(hspeed));}
		            }
		            hspeed = 0;
		            y = yTemp;
		            break;
		        }
		        yTest += vspeed / 10;
		        if (place_meeting(xTest, yTest, objBlock)) {
		            var xTemp = x;
		            x = xTest;
		            if (sign(global.grav) == 1) {
		                if(vspeed <= 0){move_contact_solid(90,abs(vspeed));}
		                if(vspeed > 0){move_contact_solid(270,abs(vspeed));djump=1;}
		            } else {
		                if(vspeed <= 0){move_contact_solid(90,abs(vspeed));djump=1;}
		                if(vspeed > 0){move_contact_solid(270,abs(vspeed));}
		            }
		            vspeed = 0;
		            x = xTemp;
		            break;
		        }
		    }
		}*/
		#endregion
		
		#region Linekid functionality
		/*if (dir_up || dir_down) {
			if ((image_angle >= 0 && image_angle < 90) || (image_angle >= 180 && image_angle < 270)) {
				if ((instance_place_check(x - 2, y, objBlock, tangible_collision) == null || instance_place_check(x + 2, y, objBlock, tangible_collision) == null) 
				|| (instance_place_check(x, y - 2, objBlock, tangible_collision) == null || instance_place_check(x, y + 2, objBlock, tangible_collision) == null)) {
					image_angle = (image_angle + (dir_up - dir_down) * 3) % 360;
				}
			}
		}*/
        
        if (dir_up || dir_down) {
        	if (dir_up) {
	        	if ((image_angle >= 0 && image_angle < 90) || (image_angle >= 180 && image_angle < 270)) {
	        		if (instance_place_check(x - 2, y, objBlock, tangible_collision) == null || instance_place_check(x + 2, y, objBlock, tangible_collision) == null) {
	        			image_angle += 3;
	        			if (image_angle > 360 || image_angle < 0) {
	        				image_angle = (image_angle + 360) mod 360;
	        			}
	        		}
	        	} else if (instance_place_check(x, y - 2, objBlock, tangible_collision) == null || instance_place_check(x, y + 2, objBlock, tangible_collision) == null) {
	        		image_angle += 3;
	        		if (image_angle > 360 || image_angle < 0) {
	        			image_angle = (image_angle + 360) mod 360;
	        		}
	        	}
        	}
        	if (dir_down) {
	        	if ((image_angle > 0 && image_angle <= 90) || (image_angle > 180 && image_angle <= 270)) {
	        		if (instance_place_check(x - 2, y, objBlock, tangible_collision) == null || instance_place_check(x + 2, y, objBlock, tangible_collision) == null) {
	        			image_angle -= 3;
	        			if (image_angle > 360 || image_angle < 0) {
	        				image_angle = (image_angle + 360) mod 360;
	        			}
	        		}
	        	} else if (instance_place_check(x, y - 2, objBlock, tangible_collision) == null || instance_place_check(x, y + 2, objBlock, tangible_collision) == null) {
	        		image_angle -= 3;
	        		if (image_angle > 360 || image_angle < 0) {
	        			image_angle = (image_angle + 360) mod 360;
	        		}
	        	}
        	}
        }	
        
	    /*if (on_block != null && instance_place_check(x, y, objBlock, tangible_collision) == null) {
			while (instance_place_check(x, y + test_dist.orig + 0.05, objBlock, tangible_collision) == null && test_dist.orig < 2) { 
				test_dist.orig += 0.05;

				if (test_dist.orig < 2) { 
					y += test_dist.orig; 
				}
			}
	    }
        
		var first_move = 0;
		var last_move_last = 0;
		var x_back = x; 
		var y_back = y;
		var blah = false;

		if (true) {
			//show_debug_message("Orig: ", test_dist.orig);
			//show_debug_message("Xpos: ", test_dist.xpos);
			//show_debug_message("Xneg: ", test_dist.xneg);
			//show_debug_message("Ypos: ", test_dist.ypos);
			//show_debug_message("Yneg: ", test_dist.yneg);
			
			var last_move = 0;	
			var list = ds_list_create();
			var line_place = instance_place_list(x, y, objBlock, list, false); 
			
			for (var i = 0; i < line_place; i++) {
				var curr_line_place = list[| i];
			
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
						
					while (instance_place(x + test_dist.xpos, y, curr_line_place) != null && test_dist.xpos < 3) {
						test_dist.xpos += 0.2;
					}
				
					while (instance_place(x - test_dist.xneg, y, curr_line_place) != null && test_dist.xneg < 3) {
						test_dist.xneg += 0.2;
					}
				
					while (instance_place(x, y + test_dist.ypos, curr_line_place) != null && test_dist.ypos < 3) {
						test_dist.ypos += 0.2;
					}
				
					while (instance_place(x, y - test_dist.yneg, curr_line_place) != null && test_dist.yneg < 3) {
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
		
			if (instance_place_check(x, y, objBlock, tangible_collision) != null) {
				test_dist.xpos = 0;
				test_dist.ypos = 0;
				test_dist.xneg = 0;
				test_dist.yneg = 0;
			
				while (instance_place(x + test_dist.xpos, y, objBlock) != null && test_dist.xpos < 3) {
					test_dist.xpos += 0.2;
				}
			
				while (instance_place(x - test_dist.xneg, y, objBlock) != null && test_dist.xneg < 3) {
					test_dist.xneg += 0.2;
				}
			
				while (instance_place(x, y + test_dist.ypos, objBlock) != null && test_dist.ypos < 3) {
					test_dist.ypos += 0.2;
				}
			
				while (instance_place(x, y - test_dist.yneg, objBlock) != null && test_dist.yneg < 3) {
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

			ds_list_destroy(list);
	        blah = true;
		}*/
		#endregion
	} else {
		image_angle = 90 * abs(global.grav) - (90 * sign(global.grav));
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
	
	#region Collision Checks
	on_block = p_instance_place(0, sign(global.grav), objBlock);
	on_ice = (p_instance_place(0, sign(global.grav), objIceBlock) ?? p_instance_place(0, 0, objIceWater));
	on_auto = (p_instance_place(0, 0, objWeirdWater) ?? p_instance_place(0, 0, objFieldAutoSpeed));
	
	if (abs(global.grav) == 1) {
		on_conveyor = (p_instance_place(0, sign(global.grav), objConveyorBlock) ?? p_instance_place(0, 0, objConveyorWater));
		on_elevator = p_instance_place(xscale, 0, objElevatorBlock);
	} else if (abs(global.grav) == 2) {
		on_conveyor = p_instance_place(0, sign(global.grav), objElevatorBlock);
		on_elevator = (p_instance_place(-xscale, 0, objConveyorBlock) ?? p_instance_place(0, 0, objConveyorWater));
	}
	
	#endregion
	
	#region Vine Checks
	var vine_off = (global.forms.linekid) ? 2 : 1;
	var on_vine = (p_instance_place(vine_off, 0, objVine) ?? p_instance_place(-vine_off, 0, objVine));
	
	if (on_vine == null && vine_mod.stick) {
		vine_mod.stick = false;
	}
	#endregion
	
	#region Speed Checks
	if (vine_mod.fire) {
		max_hspd = 6;
	} else {
		max_hspd = 3;
	}
	#endregion

	#region Gravity Checks
    if (vine_mod.lowgrav) {
        grav_amount = 0.3;
    } else if (p_instance_place(0, 0, objPlatformWater) == null) {
		grav_amount = 0.4;
		
		if (water_mod.platform) {
			water_mod.platform = false;
		}
	}
	#endregion

	package_fieldsNANG("player step");
	package_refrenture("player step");
	#endregion
	
	#region Horizontal Movement
	var flip_dir = dir * sign(-global.grav);
	var move_dir = (abs(global.grav) == 1) ? dir : dir * sign(-global.grav);
	
	if (dir != 0) {
		if (on_vine == null) {
			xscale = (abs(global.grav) == 1) ? dir : dir * sign(global.grav);

			if (p_instance_place(0, 0, objGunWater) == null) {
				if (on_ice == null) {
					if (global.slippage == 0) {
						p_hspd((abs(global.grav) == 1) ? max_hspd * dir : max_hspd * flip_dir);
					} else {
						p_hspd(approach(Hspd, (abs(global.grav) == 1) ? max_hspd * dir : max_hspd * flip_dir, global.slippage));
					}
				} else if (on_ice != null) {
					var slipdir = (abs(global.grav) == 1) ? dir : flip_dir;
					var max_slipspd = (on_ice.object_index == objIceWater) ? 1.5 : 1;
					p_hspd(approach(Hspd, (max_hspd * max_slipspd) * slipdir, on_ice.slip));
				}
				
				player_sprite(PLAYER_ACTIONS.RUN);
			} else {
				wetventure_gun_accelerate();
			}
		}
	} else {
		if (p_instance_place(0, 0, objGunWater) == null) {
			if (on_ice == null) {
				p_hspd((global.slippage == 0) ? 0 : approach(Hspd, 0, global.slippage / 2));
			} else if (on_ice != null) {
				p_hspd(approach(Hspd, 0, on_ice.slip));
			}
		} else {
			wetventure_gun_accelerate();
		}
		
		player_sprite(PLAYER_ACTIONS.IDLE);
	}
	
	if (on_auto != null) {
		p_hspd((abs(global.grav) == 1) ? max_hspd * xscale : max_hspd * -xscale);
		player_sprite(PLAYER_ACTIONS.RUN);
	}
	
	if (on_conveyor != null) {
		p_hspd(Hspd + on_conveyor.spd);
	}
	#endregion

	#region Vertical Movement
	if (!on_platform) {
		if (Vspd * sign(global.grav) < -0.05) {
		    player_sprite(PLAYER_ACTIONS.JUMP);
		} else if (Vspd * sign(global.grav) > 0.05) {
		    player_sprite(PLAYER_ACTIONS.FALL);
		}
	} else {
		if (p_instance_place(0, 4 * sign(global.grav), objPlatform) == null) {
			on_platform = false;
		}
	}
	
	if (on_elevator != null) {
		p_vspd(Vspd + on_elevator.spd);
		
		if (p_instance_place(0, -Vspd * sign(global.grav), objBlock) == null) {
			if (Vspd * sign(global.grav) <= 0) {
				player_sprite(PLAYER_ACTIONS.JUMP);
			} else if (Vspd * sign(global.grav) > 0) {
				player_sprite(PLAYER_ACTIONS.FALL);
			}
		}
	}

	if (Vspd * sign(global.grav) > max_vspd) {
		p_vspd(max_vspd * sign(Vspd));
	}
	#endregion

	#region Player Actions
	if (!frozen || on_auto) {
		#region Jump Controls
		if (is_pressed(global.controls.jump)) {
			player_jump();
		}
	
		if (is_released(global.controls.jump)) {
			player_fall();
		}
		#endregion

		if (!on_auto) {
		    #region Ladders
		    if (dir_up || dir_down) {
		        if (!on_ladder && p_instance_place(0, 0, objLadder) != null) {
		            on_ladder = true;
		            reset_jumps();
		        }
		    }
    
		    if (on_ladder) {
		        if (p_instance_place(0, 0, objLadder) == null) {
		            on_ladder = false;
		        } else {
		            grav = 0;
		            hspd = 0;
		            vspd = 0;
		            player_sprite(PLAYER_ACTIONS.CLIMB);
            
		            if (dir_up || dir_down) {
						if (instance_place_check(x, y - ((dir_up - dir_down) * max_hspd), objBlock, tangible_collision) == null) {
							y -= (dir_up) ? max_hspd : -max_hspd;
						} 
						player_sprite(PLAYER_ACTIONS.CLIMB_VERTICAL);
		            } 
				
		            if (dir_right || dir_left) {
						if (instance_place_check((x + (dir_right - dir_left) * max_hspd), y, objBlock, tangible_collision) == null) {
							x += (dir_right) ? max_hspd : -max_hspd;
						}
						
		                player_sprite(PLAYER_ACTIONS.CLIMB_HORIZONTAL);
		            }
		        }
		    }
		    #endregion
	
			#region Vines
			if (on_vine != null) {
				xscale = (on_vine.image_xscale);
				/*var relative_scales = {};
				relative_scales[$ $"{1},{0}"] = 1;
				relative_scales[$ $"{-1},{180}"] = -1;
				relative_scales[$ $"{2},{90}"] = 1;
				relative_scales[$ $"{-2},{270}"] = -1;
				var check_scale = $"{global.grav},{on_vine.image_angle}";
				
				if (variable_struct_exists(relative_scales, check_scale)) {
				    xscale = relative_scales[$ check_scale];
				} else {
				    xscale = 0;
				}*/
				
			    if (on_vine.object_index != objIceVine) {
					if (on_vine.object_index != objStickyVine) {
						var vine_speed = (on_vine.object_index == objRiseVine) ? -1 : 1;
						p_vspd((2 * vine_speed) * sign(global.grav));
					} else {
						p_vspd(0);
						vine_mod.stick = true;
					}
				} 
				
			    player_sprite(PLAYER_ACTIONS.SLIDE);
    
			    if ((on_vine.image_xscale == 1 && is_pressed(global.controls.right)) || (on_vine.image_xscale == -1 && is_pressed(global.controls.left))) {
			        if (is_held(global.controls.jump)) {
			            p_hspd((on_vine.image_xscale == 1) ? 15 : -15);
						
						if (on_vine.object_index == objFlipVine) {
							flip_grav(, false);
						}
						
						if (on_vine.object_index == objTurnVine) {
							turn_grav();
						}
						
						p_vspd(-9 * sign(global.grav));
			            player_sprite(skins.JUMP);
						audio_play_sound(sndVine, 0, false);
						
						if (on_vine.object_index == objTwinWhiteVine || on_vine.object_index == objTwinBlackVine) {
							vine_mod.twin ^= true;
						}
			        } else {
			            p_hspd((on_vine.image_xscale == 1) ? 3 : -3);
			            player_sprite(PLAYER_ACTIONS.FALL);
			        }
			    }
				
				if (on_vine.object_index == objFireVine) {
					vine_mod.fire = true;
				}
				
				if (on_vine.object_index == objLowGravVine) {
					vine_mod.lowgrav = true;
				}
			}
			
			vine_mod.count++;
			
			if (vine_mod.fire && vine_mod.count % 3 == 1) {
				instance_create_depth(x, y, depth - 1, objFireVinePart);
			}
			
			if (vine_mod.lowgrav && vine_mod.count % 10 == 1) {
				part_particles_create(global.partsys_vines, x, y, global.part_lowgrav, 2); 
			}
			#endregion
	 
			#region Debug
			if (global.debug_enable && on_block) {
				dir = (is_pressed(global.controls_debug.alignR) - is_pressed(global.controls_debug.alignL));
			
				if (dir != 0) {
					p_hspd((abs(global.grav) == 1) ? dir : dir * sign(-global.grav));
				}
			}
			#endregion
		}
	}
	#endregion
}

#region Shoot Controls
if (!frozen || on_auto) {
	if (is_pressed(global.controls.shoot) && !global.controls_lock.shoot) {
		player_shoot();
	}
	
	if (is_pressed(global.controls.suicide) && !global.controls_lock.suicide) {
		kill_player();
	}
}
#endregion

#region Physics and Collision
//Storing the previous x and y
xprevious = x;
yprevious = y;

//Moving the player manually
p_vspd(Vspd + grav);
p_x(X + Hspd);
p_y(Y + Vspd);

#region Collision with block
var block = p_instance_place(0, 0, objBlock);

if (block != null) {
	x = xprevious;
	y = yprevious;
	
	if (global.forms.lunarkid) {
		kill_player();
	} else {
		#region Detect horizontal collision
		if (p_instance_place(Hspd, 0, objBlock) != null) {
			while (p_instance_place(sign(Hspd), 0, objBlock) == null) {
				p_x(X + sign(Hspd));
			}
	
			p_hspd(0);
		}
		#endregion

		#region Detect vertical collision
		if (!global.forms.linekid || (p_instance_place(0.6, Vspd, objBlock) != null || p_instance_place(-0.6, Vspd, objBlock) != null)) {
			if (p_instance_place(0, Vspd, objBlock) != null) {
				while (p_instance_place(0, sign(Vspd), objBlock) == null) {
					p_y(Y + sign(Vspd));
				}
		
				if (Vspd * global.grav > 0) {
					reset_jumps();
				}
		
				p_vspd(0);
				grav = 0;
			}
		} else if (global.forms.linekid && on_block == null) {
			p_x((p_instance_place(0.6, Vspd, objBlock) == null) ? X + 0.6 : X - 0.6);
		}
		#endregion

		#region Detect diagonal collision
		if (instance_place_check(x + hspd, y + vspd, objBlock, tangible_collision) != null) {
			#region Linekid stupid fucking double collision check
			var test_pos = [x, y];
			
			while (true) {
				#region Detect horizontal collision
				test_pos[0] += hspd / 10;
				if (instance_place_check(test_pos[0], test_pos[1], objBlock, tangible_collision) != null) {
					var temp_y = y;
					p_y(test_pos[1]);
					
					if (instance_place_check(x + hspd, y, objBlock, tangible_collision) != null) {
						while (instance_place_check(sign(hspd), y, objBlock, tangible_collision) == null) {
							p_x(x + sign(hspd));
						}
				
						p_hspd(0);
						p_y(temp_y);
					}
					break;
				}
				#endregion
				
				#region Detect vertical collision
				test_pos[1] += vspd / 10;
				if (instance_place_check(test_pos[0], test_pos[1], objBlock, tangible_collision) != null) {
					var temp_x = x;
					p_x(test_pos[0]);
					
					if (instance_place_check(x, y + vspd, objBlock, tangible_collision) != null) {
						while (instance_place_check(x, y + sign(vspd), objBlock, tangible_collision) == null) {
							p_y(y + sign(vspd));
						}
				
						if (vspd * global.grav > 0) {
							reset_jumps();
						}
				
						p_vspd(0);
						grav = 0;
						p_x(temp_x);
					}
					break;
				}
				#endregion
			}
			#endregion
			var platform = p_instance_place(0, Vspd, objPlatform);
			
			if (!platform || p_instance_place(0, 0, platform) != null) {
				p_hspd(0);
			} else {
				p_vspd(0);
			}
		}
		#endregion
		
		p_x(X + Hspd);
		p_y(Y + Vspd);
	}
}
xsafe = xprevious + hspd;
ysafe = yprevious + vspd;
#endregion
#endregion