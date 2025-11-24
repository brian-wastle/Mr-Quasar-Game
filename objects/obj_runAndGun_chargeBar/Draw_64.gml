draw_sprite_ext(sprite_index, image_index, 132, 180, 1, 1, 0, c_white, 1);

draw_set_color(#f5efff);
draw_rectangle(132 + 4, 180 + 4, 132 + 4 + barWidth, 180 + 16, false);
draw_set_color(#0b0911);
draw_rectangle(132 + 4 + barWidth, 180 + 4, 132 + 8 + barWidth, 180 + 16, false);

draw_sprite_ext(spr_runAndGun_chargeBarOverlay, 0, 132, 180, 1, 1, 0, c_white, 1);