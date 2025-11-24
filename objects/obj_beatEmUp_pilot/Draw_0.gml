
//if (objectState = 3) {
//		draw_sprite_ext(spr_beatEmUp_jetExhaust, exhaustIndex, x, y + shakeOffset, 1, 1, 0, c_white, 1);
//		draw_sprite_ext(spr_beatEmUp_jetFlame, flameIndex, x, y + shakeOffset, 1, 1, 0, c_white, 1);
//	}

//if ( objectState == 4 && image_index = 1 ) {
//	draw_sprite_ext(spr_beatEmUp_jetFlame, flameIndex, x, y + shakeOffset, 1, 1, 0, c_white, 1);
//}

//draw_sprite_ext(sprite_index, image_index, x, y + shakeOffset, 1, 1, 0, c_white, 1);


// Function to round to the nearest multiple of 4
function roundToGrid(val) {
    return round(val / 4) * 4;
}

// Draw jet exhaust if in state 3
if (objectState == 3) {
    draw_sprite_ext(
        spr_beatEmUp_jetExhaust, 
        exhaustIndex, 
        roundToGrid(x), 
        roundToGrid(y + shakeOffset), 
        1, 1, 0, c_white, 1
    );
    draw_sprite_ext(
        spr_beatEmUp_jetFlame, 
        flameIndex, 
        roundToGrid(x), 
        roundToGrid(y + shakeOffset), 
        1, 1, 0, c_white, 1
    );
}

// Draw jet flame if in state 4 and at specific image index
if (objectState == 4 && image_index == 1) {
    draw_sprite_ext(
        spr_beatEmUp_jetFlame, 
        flameIndex, 
        roundToGrid(x), 
        roundToGrid(y + shakeOffset), 
        1, 1, 0, c_white, 1
    );
}

// Draw main sprite with grid alignment
draw_sprite_ext(
    sprite_index, 
    image_index, 
    roundToGrid(x), 
    roundToGrid(y + shakeOffset), 
    1, 1, 0, c_white, 1
);


//draw_text(200, 200, tapTimer);