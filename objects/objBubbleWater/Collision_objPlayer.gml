if (sign(global.grav) == -sign(VSPD)) {
    if (VSPD * sign(global.grav) > 0) {
        p_vspd(0.5 * sign(global.grav));
    }
} else {
    p_vspd(approach(VSPD, spd, 0.15));
}