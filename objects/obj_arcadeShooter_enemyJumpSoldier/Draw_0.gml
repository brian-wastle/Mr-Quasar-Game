


if (blinkVar) {
	shader_set(sha_horiShmup_scrapFlash);
	draw_sprite_ext(sprite_index,image_index,x,y,xSide,1,0,c_white,1); //body

draw_sprite_ext(enemyFace, poseIndex, x, y, xSide, 1, 0, c_white, 1); //head
	shader_reset();
} else {
	draw_sprite_ext(sprite_index,image_index,x,y,xSide,1,0,c_white,1); //body

	draw_sprite_ext(enemyFace, poseIndex, x, y, xSide, 1, 0, c_white, 1); //head
}
