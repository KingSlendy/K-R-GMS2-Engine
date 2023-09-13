function power_sprite() {
    var target = objPlayer;
    
    if (instance_exists(target)) {
        sprite = (global.forms.dotkid || global.forms.lunarkid || global.forms.linekid) ? target.sprite_index : sprPlayerIdle;
    } else {
        exit;
    }
}
power_sprite();