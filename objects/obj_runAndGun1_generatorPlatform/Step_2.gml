y = initialY + yOffset;


	if (place_meeting(x,y - 1,obj_RunAndGun_Player) && !place_meeting(x,y,obj_RunAndGun_Player)) {
		if (yOffset < 40) {
			yOffset += 4;
		    obj_RunAndGun_Player.y += 4;
			obj_RunAndGun_Player.actionstate = 0;
			obj_RunAndGun_Player.vsp = 0;
		} else if (triggerEffect == 0 && chargeCount < 4) {
			triggerEffect = 1;
			chargeCount += 1;
			instance_create_layer(528, 652, "Objects", obj_runAndGun1_generatorFlash, {
				chargeCount: chargeCount
			});
			lightInst.image_index += 1;
		}
	} else if (yOffset > 0) {
		yOffset -= 1;
	} else {
		triggerEffect = 0;
	}
