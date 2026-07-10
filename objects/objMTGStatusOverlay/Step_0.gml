
#region Experience Precalculation
if (global.experience_gain > 0) {
    global.stats_mtg.current_exp += global.experience_gain;
    if (global.stats_mtg.current_exp + global.experience_gain >= global.stats_mtg.needed_exp) {
        global.stats_mtg.current_exp -= global.stats_mtg.needed_exp;
        global.stats_mtg.level++;
    }
    global.experience_gain = 0;
}
#endregion

if (xp.current < xp.needed) {
    #region Gaining Experience
    if (xp.gained > 0) {
        if (!audio_is_playing(sndMTGExpGain)) {
            audio_play_sound(sndMTGExpGain, 0, false);
            xp.summed = (xp.gained > xp.needed) ? ceil(xp.needed / 40) : ceil(xp.gained / 40);
        }
        
        tick = approach(tick, 0, 1);
        if (tick == 0) {
            if (xp.summed > xp.gained) {
                xp.summed = xp.gained;
            }
            xp.total = (xp.summed > xp.needed - xp.current) ? xp.needed - xp.current : xp.summed;
            
            xp.gained -= xp.total;
            xp.current += xp.total;
            if (xp.current == xp.needed) {
                audio_stop_sound(sndMTGExpGain);
                audio_play_sound(sndMTGLevelGain, 0, false);
            } else {
                tick = 2;
            }
        }
    } else {
        if (audio_is_playing(sndMTGExpGain)) {
            audio_stop_sound(sndMTGExpGain);
        }
    }
    #endregion
} else {
    #region Leveling Up
    
    #endregion
}