draw_self();

if (sprite_index = spr_vertShmup_EnemyLaserTop && image_speed = 0 && laserTimer < laserEnd) {
	draw_sprite_ext(spr_vertShmup_EnemyLaserBottom, 0,x,y + 30 + topIndex,1,1,0,c_white,1)
	topIndex = (topIndex * 1.08) + 1;
}

if (topIndex > 0 && laserTimer < laserEnd) {
	draw_sprite_stretched(spr_vertShmup_EnemyLaserMiddle,0,x - 45,y + 30,90,topIndex)
}

if (topIndex > 800) {
	topIndex = 800
}