if (blinkVar) {
	shader_set(sha_horiShmup_scrapFlash);
	draw_self();
	shader_reset();
} else {
	draw_self();
}

if (enemyEventTimer < 170) {
	draw_sprite_ext(spr_horiShmup_enemyJetFlame,image_index,x+152,y,1,1,0,c_white,1);
}
if (enemyEventTimer >= 270) {
	draw_sprite_ext(spr_horiShmup_enemyJetFlame,image_index,x+152,y,1,1,0,c_white,1);
}
