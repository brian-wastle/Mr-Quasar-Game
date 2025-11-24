if (hitRegistered == 1) {
    gpu_set_blendmode(bm_add);
    draw_sprite_ext(sprite_index, currentIndex, x, y + vibrationOffset, currentDir * -1, 1, 0, c_white, .8);
    gpu_set_blendmode(bm_normal);
} else {
    draw_sprite_ext(sprite_index, currentIndex, x, y + vibrationOffset, currentDir * -1, 1, 0, c_white, 1);
}


draw_text(x + 50, y - 400, bossInst.enemyHealth);

draw_text(x, y - 500, bossInst.damageState);

draw_text(x, y - 600, enemyState);

//draw_text(x + 250, y - 735, );

//draw_text(x + 200, y - 550, );
