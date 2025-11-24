depth = 199;
lightInstL = instance_create_layer(748,932, "Objects", obj_runAndGun1_generatorLights);
platformInstL = instance_create_layer(788,800, "Objects", obj_runAndGun1_generatorPlatform, {
	lightInst: lightInstL
});

lightInstR = instance_create_layer(1156,932, "Objects", obj_runAndGun1_generatorLights);
platformInstR = instance_create_layer(1160,800, "Objects", obj_runAndGun1_generatorPlatform, {
	lightInst: lightInstR
});

generatorState = 0;