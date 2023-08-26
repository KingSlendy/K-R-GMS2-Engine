if (sign(global.grav) == -sign(Vspd)) {
    if (Vspd * sign(global.grav) > 0) {
        p_vspd(0.5 * sign(global.grav));
    }
} else {
    p_vspd(approach(Vspd, spd, 0.15));
}