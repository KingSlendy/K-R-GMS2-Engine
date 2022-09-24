if (global.grav == -sign(vspd)) {
    if (other.vspd * global.grav > 0) {
        other.vspd = 0.5 * global.grav;
    }
} else {
    other.vspd = approach(other.vspd, vspd, 0.15);
}