draw_sprite_ext(spr_vertShmup_EnemyEShipWaveBase, baseIndex, x, y, beamWidth, 1, 0, c_white, opac);


if (baseIndex >= 8) {
	draw_sprite_ext(sprite_index, 0, x, y + 31 + bulletTimer, beamWidth, 1 + bulletTimer, 0, c_white, opac);
	draw_sprite_ext(spr_vertShmup_EnemyEShipWaveCap, 0, x, y + 31 + bulletTimer, beamWidth, 1, 0, c_white, opac);
}


if (bulletTimer > 100) {
	draw_sprite_ext(spr_vertShmup_EShipWaveShock, shockIndex, x, y + 11, 1, 1, 0, c_white, 1);
}
