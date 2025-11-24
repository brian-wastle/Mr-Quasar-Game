draw_sprite_ext(spr_BeatEmUp_PlayerShadow,0,x,y,shadowSize,shadowSize,0,c_white,.3);
//draw_sprite_ext(mask_index,0,x,y,1,1,0,c_white,1);
draw_sprite_ext(sprite_index, image_index, x + shakeOffset, y - zsp, -dirOffset, 1, 0, c_white, currentOpac);
draw_set_color(c_red);
//draw_text(x + 70, y - 45, string_concat("enemyState: ",enemyState));
//draw_text(x + 70, y - 75, string_concat("enemyHealth: ",enemyHealth));
//draw_text(x + 70, y - 105, string_concat("hitflag: ",hitflag));
//draw_text(x + 70, y - 135, string_concat("iFrameTimer: ",iFrameTimer));
//draw_text(x + 70, y - 165, string_concat("freezeTimer: ", freezeTimer));

//draw_text(x + 180, y - 135, string_concat("zsp: ",zsp));
//draw_text(x + 180, y - 165, string_concat("yGoal: ", yGoal));

draw_set_color(c_white);