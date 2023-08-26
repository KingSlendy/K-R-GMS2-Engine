if (!visible) {
	exit;
}

other.jump_left = (object_index == objJumpDefresh) ? 0 : approach(other.jump_left, other.jump_total - 1, 1);
visible = false;
alarm[0] = refresh_frames;

switch(object_index) {
    case objHighJumpRefresh:
    other.jump_mod.high = 1;
    other.jump_mod.low = 0;
    break;
            
    case objLowJumpRefresh:
    other.jump_mod.high = 0;
    other.jump_mod.low = 1;
    break;
            
    case objFlipJumpRefresh:
    other.jump_mod.flip = 1;
    break;
            
    case objJumpTelefresh:
    other.jump_mod.tele = 1;
    break;
            
    case objFastJumpRefresh:
    other.jump_mod.fast = 1;
    break;
            
    case objSwitchJumpRefresh:
    other.jump_mod.swap = 1;
    break;
            
    case objSlowmoJumpRefresh:
    other.jump_mod.slowmo = 1;
    break;
}