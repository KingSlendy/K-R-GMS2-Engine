if (instance_exists(objPlayer)) {
    if (!active && instance_place(x - objPlayer.hspd, y - objPlayer.vspd, objPlayer)) {
        audio_play_sound(sndSheepBlock, 0, false);
        
        with (objSheepBlock) {
            if (image_blend == other.image_blend) {
                if (xcurrent == other.xcurrent && ycurrent == other.ycurrent) {
                    anim_speed = 0.2;
                    active = true;
                }
            }
        }
        
        with (objSheepSpike) {
            if (image_blend == other.image_blend) {
                if (xcurrent == other.xcurrent && ycurrent == other.ycurrent) {
                    anim_speed = 0.2;
                    active = true;
                }
            }
        }
    }
}

if (active) {
    anim_timer += anim_speed;
    if (anim_timer < 2) {
        image_blend = (floor(anim_timer) == 1) ? make_color_rgb(212, 212, 212) : color;
    }
    
    if (anim_timer >= 2) {
        anim_speed = approach(anim_speed, 0.5, 0.025);
        if (anim_speed == 0.5) {
            instance_destroy();
        }
        anim_timer -= 2;
    }
}