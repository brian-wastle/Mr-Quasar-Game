// Detect level changes
if (level != global.lastLevel) {
    loadDialog(level);
    global.lastLevel = level;
	boxPosArray = [];
}

// Detect scene changes
if (scene != global.lastScene) {
    boxIndex = 1;
    global.lastScene = scene;
	var sceneString = string(scene);

    // Collect box keys for this scene
    if (struct_exists(dialogData, sceneString)) {
		var sceneKey = string(level) + "_" + string(scene);
        var sceneStruct		= dialogData[$ sceneString];
        var boxKeys			= struct_get_names(sceneStruct);
        totalBoxes			= array_length(boxKeys);
		boxPosArray			= positionData[$ sceneKey];
    } else {
        totalBoxes			= 0;
    }
}

// If no textbox is active, spawn the next one
if (!instance_exists(currentTextbox) && totalBoxes > 0 && boxIndex <= totalBoxes) {
	var sceneString = string(scene);
    if (struct_exists(dialogData, sceneString)) {
        var sceneStruct		= dialogData[$ sceneString];
        var boxKeys			= struct_get_names(sceneStruct);
        var boxKey			= boxKeys[boxIndex - 1];
        var boxStruct		= sceneStruct[$ boxKey]; 
		var boxPos			= boxPosArray[boxIndex - 1];

        // Create the textbox instance
        currentTextbox = instance_create_layer(12988, 440, "Instances", obj_textbox, {
            boxData: boxStruct,		// pass the script data struct
			boxPos: boxPos
        });
        boxIndex++;
    }
}
