// Set location
x = parentId.x;
y = parentId.y;
directionOffset = parentId.directionOffset;
sideIndex = (-directionOffset + 1) / 2;
hitType = (parentId.airAttackState == 1 || parentId.airAttackState == 2) ? 1 : 0; 

// Create hit effect
var enemy = instance_place(x, y, obj_beatEmUp_enemy);
if (enemy != noone && hitflagState == 0) {
	var playerZsp = obj_beatEmUp_player.zsp;
	if (enemy.enemyState != 13 && (playerZsp >= enemy.zsp && abs(playerZsp - enemy.zsp) <= 120) || 
	(playerZsp < enemy.zsp && (abs(playerZsp - enemy.zsp) < 180))) {
	    with (enemy) {
			var player = obj_beatEmUp_player;
			var actionstate = player.actionstate;
			// If enemy is in stun lock
			if (enemyState == 6) {
				if (actionstate == 3) {
					other.genHitEffect();
				} else if (player.airAttackState == 1) {
				// If player is in air attack 1
					var zDiff = player.zsp - zsp;	//Enemy below player returns positive value
					if (zDiff < 144) {
						other.genHitEffect();
					}
				} else if (player.airAttackState == 2) {
				// If player is in spike
					var zDiff = player.zsp - zsp;	//Enemy below player returns positive value
					if (zDiff < 272) {
						instance_create_layer(player.x, player.y, "Instances", obj_beatEmUp_slamEffect);
					}
				}
			
			// If enemy is already knocked back
			} else if (enemy.enemyState == 7) {
				// If player is in combo attack and enemy is in the air -- juggle
				if (zsp > 90 && (knockbackState > 0 && knockbackState < 11) 
				&& actionstate == 3) {
					other.genHitEffect();
				} else if ((knockbackState > 0 && knockbackState < 11) && player.airAttackState == 1) {
				// If player is in air attack 1
					var zDiff = player.zsp - zsp;	//Enemy below player returns positive value
					if (zsp > 12 && zDiff < 12 && zDiff > -160) {
						other.genHitEffect();
					}
				} else if ((knockbackState > 0 && knockbackState < 11) && player.airAttackState == 2) {
				// If player is in spike
					var zDiff = player.zsp - zsp;	//Enemy below player returns positive value
					if (zDiff < 128 && zDiff > 12) {
						instance_create_layer(player.x, player.y, "Instances", obj_beatEmUp_slamEffect);
					}
				}

			// If enemy is on their feet
			} else if (enemy.enemyState != 7) {
				// If player is in combo attack
				if (actionstate == 3) {
					other.genHitEffect();
				} else if (player.airAttackState == 1) {
				// If player is in air attack 1
					var zDiff = player.zsp - zsp;	//Enemy below player returns positive value
					if (zDiff < 144) {
						other.genHitEffect();
					}
				} else if (player.airAttackState == 2) {
				// If player is in spike
					var zDiff = player.zsp - zsp;	//Enemy below player returns positive value
					if (zDiff < 272) {
						instance_create_layer(player.x, player.y, "Instances", obj_beatEmUp_slamEffect);
					}
				}
			}
	    }
	    hitflagState = hitflag; // Prevent duplicates
	}
}


// Set Sprites
if (parentId.actionstate == 3) {
    sprite_index = charArray[1, playerChar][sideIndex];
    image_index = parentId.image_index;
} else if (parentId.actionstate == 11) {
	sprite_index = charArray[3, playerChar][sideIndex];
    image_index = parentId.image_index;
} else if ((parentId.actionstate == 2 || parentId.actionstate == 14) && parentId.airAttackState == 1) {
    sprite_index = charArray[2, playerChar][sideIndex];
    image_index = parentId.image_index;
} else if ((parentId.actionstate == 2 || parentId.actionstate == 14) && parentId.airAttackState == 2) {
    sprite_index = charArray[4, playerChar];
    image_index = parentId.image_index;
} else {
    sprite_index = charArray[0, playerChar];
    image_index = 0;
}

// Handle hitflag state
if ((parentId.actionstate == 3 && image_index != currentIndex) || (hitType != hitTypePrevious)) {
    hitflag *= -1;
    if (hitflagState != hitflag) {
        hitflagState = 0;
    }
}



// Update currentIndex
currentIndex = image_index;
hitTypePrevious = hitType;