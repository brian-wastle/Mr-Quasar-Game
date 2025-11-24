//draw legs
draw_sprite_ext(sprite_index,image_index,x,y,xOffset,1,0,c_white,1);
//draw_sprite_ext(mask_index,0,x,y,xOffset,1,0,c_white,1);

//draw torso
if (headSprite != noone) {
    draw_sprite_ext(headSprite,image_index,x,y,xOffset,1,0,c_white,1);
}


//draw_text(x - 50, y + 100, string_concat("vx: ", vx));
//draw_text(vx + 50, 540, string_concat("vx + 50: ", vx));
//draw_text(vx + vw - 50, 540, string_concat("vx + vw - 50: ", vx + vw - 50));
//draw_text(x - 50, y + 180, string_concat("x: ", x));