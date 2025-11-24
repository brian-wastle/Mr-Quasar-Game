if (enemyHealth <= 0) {
	enemyHealth = 0;
	if (objectType = 0 || objectType = 2) {
		depth = 100
		if (y < floorY) {
			var grav = 0.5;        
			var maxFallSpeed = 50;    
			ySpeed = min(ySpeed + grav, maxFallSpeed);
			x += xSpeed;
			image_angle += rotationSpeed;
			if (image_angle >= 360) {
				image_angle = 0;
			}
		} else {
			image_angle = 180;
			if (sprite_index = spr_arcadeShooter_swords && image_index > 1) {
				image_angle = 270;
			}
		}
		if (effectsTrigger = 0 && image_index = 0) {
			for (var i = 0; i < array_length(effectObjects); ++i) {
				instance_create_layer(x,y,"Instances", effectObjects[i], {
					spriteIndex: effectOptions[i].spriteIndex,
					func: effectOptions[i].func
				});
			}
			if (objectType = 0) {
				if (image_index = 0 && image_number > 1) {
					for (var i = 1; i < image_number; ++i) {
						instance_create_layer(x,y,"Instances", obj_arcadeShooter_bounceDest, {
							sprite_index: sprite_index,
							image_index: i,
							offset: offset,
							rotationSpeed: irandom_range(8,24),
							effectObjects: [], //any effects that are triggered when the object is struck by a bullet
							effectOptions:[] //plus pass in associated configuration options
						});
					}
				}
				if image_number > 1 {
					instance_destroy();
				}
			} else if (objectType = 2) {
				image_index = 1;
			}
			effectsTrigger = 1;
		}
		if (y + ySpeed <= floorY) {
			y += ySpeed;
		} else {
			y = floorY;
		}
	} else if (objectType = 1) {
		image_speed = 2;
		if image_index >= image_number - 1 {
			instance_destroy();
			if (sprite_index = spr_arcadeShooter_wine) {
				instance_create_layer(1524, 548, "Instances", obj_arcadeShooter_wineSplash);
			}
		}
		if (effectsTrigger = 0 && image_index = 0) {
			for (var i = 0; i < array_length(effectObjects); ++i) {
				instance_create_layer(x,y,"Instances", effectObjects[i], {
					spriteIndex: effectOptions[i].spriteIndex,
					func: effectOptions[i].func
				});
			}
		}
	}
}
