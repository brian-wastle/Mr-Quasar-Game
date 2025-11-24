
if (blinkVar) {
	shader_set(sha_horiShmup_scrapFlash);
	draw_self();
	shader_reset();
} else {
	draw_self();
}