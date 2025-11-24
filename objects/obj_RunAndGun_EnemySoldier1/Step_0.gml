
if (x > obj_RunAndGun_Player.x) {
	spriteDir = -1;
} else {
	spriteDir = 1;
}

var bulletDir = -90 * spriteDir + 90;


playerDir = point_direction(x,y,obj_RunAndGun_Player.x, obj_RunAndGun_Player.y);

if (playerDir > 60/64 * 360 || playerDir <= 4/64 * 360) { /*right*/
	image_index = 0;
}
if (playerDir > 4/64 * 360 && playerDir <= 12/64 * 360) { /*upright*/
	image_index = 2;
}
if (playerDir > 52/64 * 360 && playerDir <= 60/64 * 360) { /*downright*/
	image_index = 4;
}
if (playerDir > 28/64 * 360 && playerDir <= 36/64 * 360) { /*left*/
	image_index = 0;
}
if (playerDir > 20/64 * 360 && playerDir <= 28/64 * 360) { /*upleft*/
	image_index = 2;
}
if (playerDir > 36/64 * 360 && playerDir <= 44/64 * 360) { /*downleft*/
	image_index = 4;
}
if (playerDir > 12/64 * 360 && playerDir <= 20/64 * 360) { /*up*/
	image_index = 2;
}
if (playerDir > 44/64 * 360 && playerDir <= 52/64 * 360) { /*down*/
	image_index = 4;
}

nearestAngle = 45 * round(playerDir/45);
if (nearestAngle = 270) {
	if (x <= obj_RunAndGun_Player.x) {
		nearestAngle += 45;
	} else {
		nearestAngle -= 45;
	}
}

if (nearestAngle = 90) {
	if (x <= obj_RunAndGun_Player.x) {
		nearestAngle -= 45;
	} else {
		nearestAngle += 45;
	}
}


bulletTimer += 1;
if bulletTimer >= 50 {
	instance_create_layer(x,y,"Instances",obj_RunAndGun_EnemyBullet1, {
		speed:20,
		direction:nearestAngle,
		spriteDir:spriteDir
	});
	bulletTimer = 0;
	poseTimer = 15;
}

if poseTimer > 0 {
	poseTimer -= 1;
	image_index += 1;
}



ds_list_clear(bulletList);
collisionList = instance_place_list(x, y, obj_runAndGun_ParentPlayerBullet, bulletList, 0);

if collisionList > 0 {
	for (var i = 0; i < collisionList; ++i;) {
		
		var inst = ds_list_find_value(bulletList,i)
		enemyHealth -= 25;
		
		instance_destroy(inst);
    }
		
	if (blinkVar = false) {
		blinkVar = true;
	} else {
		blinkVar = false;
	}
} else {
	blinkVar = false;
}

if (enemyHealth <= 0) { 
	instance_destroy();
}