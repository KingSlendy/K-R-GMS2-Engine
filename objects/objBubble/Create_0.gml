hspd = 0;
vspd = 0;
spd = 0;

scale = 1;
active = false;
pop = false;

function spd_dir() {
    return point_direction(0, 0, hspd, vspd);
}

function spd_set(spd = spd_get(), dir = spd_dir()) {
    hspd = lengthdir_x(spd, dir);
    vspd = lengthdir_y(spd, dir);
}

function spd_get() {
    return point_distance(0, 0, hspd, vspd);
}