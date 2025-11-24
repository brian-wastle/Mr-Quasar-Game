if (moverState != 2) {
	exhaustIndex = irandom(7);
	var alpha = random_range(.4,.5);
    if (dirState == -1) {
	    draw_sprite_ext(spr_runAndGun2_cmFlame, exhaustIndex, x + 56, y - 4, 1, 1, 0, c_white, alpha);
	} else {
		draw_sprite_ext(spr_runAndGun2_cmFlame, exhaustIndex, x - 60, y - 4, -1, 1, 0, c_white, alpha);
	}
}
if (moverState == 2) {
	draw_sprite_ext(spr_runAndGun2_cmFlameTurn, image_index, x, y, 1, 1, 0, c_white, .5);
}

var a = (boundsBGView / 100) * 0.5;
draw_self();
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_black, a);