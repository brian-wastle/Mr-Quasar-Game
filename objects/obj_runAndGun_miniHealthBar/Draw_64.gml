draw_sprite_ext(spr_runAndGun_miniHealthBar, 0, 524, 240, 1, 1, 0, c_white, 1);

if (objState == 0) {
	draw_sprite_ext(spr_runAndGun_bullLoading, loadingIndex, 536, 280, 1, 1, 0, c_white, 1);
	// Bar 1
	if (fillPhase[0] > 0) {
	    draw_set_color(#48434c);
		draw_rectangle(524, 240, 524 + fillPhase[0], 240 + 20, false);
		draw_set_color(#625e66);
		draw_rectangle(524, 240, 524 + fillPhase[0], 240 + 4, false);
	}
	// Bar 2
	if (fillPhase[1] > 0) {
	    draw_set_color(#48434c);
		draw_rectangle(524 + 324, 240, 524 + 324 + fillPhase[1], 240 + 20, false);
		draw_set_color(#625e66);
		draw_rectangle(524 + 324, 240, 524 + 324 + fillPhase[1], 240 + 4, false);
	}
	//// Bar 3
	if (fillPhase[2] > 0) {
		draw_set_color(#9f1010);
		draw_rectangle(524 + 2 * 324, 240, 524 + 2 * 324 + fillPhase[2], 240 + 20, false);
		draw_set_color(c_white);
	} if (fillPhase[2] == 320) {
		objState = 1;
	}
} else {
	// Draw Health
	if (currentHealth > 0) {
	    draw_set_color(#9f1010);
		draw_rectangle(524 + (bullPhase * 324), 240, 524 + (bullPhase * 324) + barLength, 240 + 20, false);
		// Draw Reserves
		if (bullPhase - 1 >= 0) {
			for (var i = 0; i < bullPhase; ++i) {
				draw_set_color(#48434c);
			    draw_rectangle(524 + (i * 324), 240, 524 + (i * 324) + 320, 240 + 20, false);
				draw_set_color(#625e66);
				draw_rectangle(524 + (i * 324), 240, 524 + (i * 324) + 320, 240 + 4, false);
			}
		}
	}
	// Draw Loading Sprite
	if (loadingAlpha > 0) {
		draw_sprite_ext(spr_runAndGun_bullLoading, loadingIndex, 536, 280, 1, 1, 0, c_white, loadingAlpha);
	} else {
		loadingIndex = 0;
	}
	draw_set_color(c_white);
}

draw_sprite_ext(spr_runAndGun_miniHealthBarCover, 0, 524, 240, 1, 1, 0, c_white, 1);