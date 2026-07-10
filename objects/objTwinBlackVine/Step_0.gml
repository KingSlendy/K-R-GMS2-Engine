if (instance_exists(objPlayer)) {
    active = objPlayer.vine_mod.twin;
}

image_alpha = (!active) ? 0.3 : 1;
image_speed = active;