
if (blinkVar) {
	shader_set(sha_horiShmup_scrapFlash);
	draw_self();
	shader_reset();
} else {
	draw_self();
}


//if (path_exists(movementPath)) {
//	draw_path(movementPath,x,y,1)
//}

