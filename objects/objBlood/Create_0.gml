image_index = irandom(image_number - 1);

direction = irandom(35) * 10;
speed = random(6);
gravity_direction = (abs(global.grav) == 1) ? 270 : 0;
gravity = (0.1 + random(0.2)) * sign(global.grav);
