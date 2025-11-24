draw_sprite_ext(spr_runAndGun_uiBg,0,112,64,1,1,0,c_white,1);

draw_sprite_ext(spr_runAndGun_weaponIcon,bulletType,488,96,1,1,0,c_white,1);

for (var i = 0; i < array_length(heartArray); ++i) {
    draw_sprite_ext(heartSprArray[i],heartArray[i],156 + (i * 60),100,1,1,0,c_white,1);
}