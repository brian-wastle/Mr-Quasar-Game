if (place_meeting(x,y,obj_runAndGun_ParentOverlay)) {
	instance_create_layer(x,y,"Instances", obj_runAndGun_bulletImpact, {
		dirIndex: image_index,
		impactOffset: spriteDir
	});
	instance_destroy();
}

if (place_meeting(x, y, obj_runAndGun_ParentEnemy)) {
    var hit = instance_place(x, y, obj_runAndGun_ParentEnemy);
	var impactOwner = hit;
	// update enemy damage flag
    hit.hitFlag     = 1;
    hit.bulletInst  = id;
    hit.rifleCharge = rifleCharge;
	// Back out
    if (impactOwner) {
		var px = x;
		var py = y;
		
		var impactDir = direction + 180;
		for (var i = 0; i < speed + 8; ++i) {
		    if (hit) {
				px += lengthdir_x(1,impactDir);
				py += lengthdir_y(1,impactDir);
				hit = instance_place(px, py, obj_runAndGun_ParentEnemy);
			}
		}
		// spawn at last safe spot
		px -= lengthdir_x(8,impactDir);
		py -= lengthdir_y(8,impactDir);
	
	    instance_create_layer(px, py, "Instances", obj_runAndGun_bulletImpact, {
	        dirIndex: image_index,
	        impactOffset: spriteDir,
	        owner: impactOwner,
			initialIndex: irandom(2) * 5
	    });
	    instance_destroy();
	}
    
}

if (stateTimer[0] < 180) {
    stateTimer[0] += 1;
} else {
	instance_destroy();
}