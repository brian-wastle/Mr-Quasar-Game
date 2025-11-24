for (var i = 0; i < array_length(gridPositions); i++) {
    var pos = gridPositions[i];
    var rotation = gridRotations[i];
    draw_sprite_ext(
        spotlightSprite, 0, 
        pos[0], pos[1], 
        1, 1, rotation, c_white, 1
    );
}

//draw_text(960,200,string_concat("scrollOffset: ", scrollOffset));
//draw_text(960,220,string_concat("scrollOffset + imageSpacing: ", scrollOffset + imageSpacing));
//draw_text(960,240,string_concat("scrollOffset - imageSpacing: ", scrollOffset - imageSpacing));
