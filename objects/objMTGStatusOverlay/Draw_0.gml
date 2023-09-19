switch(type) {
    case "original":
    draw_sprite_ext(sprBkgBlock_MTGRocks, 0, 0, 0, 6, room_height / 32, 0, c_white, 1);
    break;
    
    default:
    for (var i = 0; i < 3; i++) {
        draw_sprite_ext(sprBlock_NAMTGBricksLeft, i, 0, 192 * i, 1, 6 + (i == 2), 0, c_white, 1);
        draw_sprite_ext(sprBlock_NAMTGBricks, i, 32, 192 * i, 4, 6 + (i == 2), 0, c_white, 1);
        draw_sprite_ext(sprBlock_NAMTGBricksRight, i, 160, 192 * i, 1, 6 + (i == 2), 0, c_white, 1);
    }
    break;
}