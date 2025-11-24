
draw_sprite(spr_twinStickShooter_staminaUnderlay, 0, x, y);

if (!surface_exists(surf)) {
    surf = surface_create(300, 300);
}
//mask
surface_set_target(surf);
	draw_clear_alpha(c_black, 0);
	draw_set_color($3e3e3e);
	draw_pie(50,50,250,250,xCoordinate,yCoordinate,70,140,false,64);
	draw_set_color(c_white);
	gpu_set_blendmode(bm_subtract);
	draw_sprite(spr_twinStickShooter_staminaMask,0,150,150);
	gpu_set_blendmode(bm_normal);
surface_reset_target();

draw_surface(surf, x - 150, y - 150);
draw_sprite(spr_twinStickShooter_staminaOverlay, 0, x, y);
draw_sprite_ext(spr_twinStickShooter_staminaNeedle,0,x-4,y,1,1,needleAngle,c_white,1);

draw_sprite_ext(spr_twinStickShooter_gaugeUnderlay,0,304,370,1,1,0,c_white,1);
draw_sprite_ext(spr_twinStickShooter_font1,staminaIndex[0] +2,304,370,1,1,0,c_white,1);
draw_sprite_ext(spr_twinStickShooter_font1,staminaIndex[1] +2,358,370,1,1,0,c_white,1);
draw_sprite_ext(spr_twinStickShooter_font1,staminaIndex[2] +2,408,370,1,1,0,c_white,1);
draw_sprite_ext(spr_twinStickShooter_percent,0,468,370,1,1,0,c_white,1);

