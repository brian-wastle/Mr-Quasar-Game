level							= 0; // Set to 0 prior to initialization
scene							= 0; // Set to 0 prior to initialization
boxIndex						= 1;
pageIndex						= 1;
totalBoxes						= 0;
currentTextbox					= noone;
dialogData						= {};
positionData					= {};
boxPosArray						= [];
tempData = [];

global.lastLevel = 0;
global.lastScene = 0;

function loadDialog(_level) {
    // Reset local dialog data
    dialogData	= {};
    level		= _level;
    scene		= 0; // This will be initialized by a control object
    boxIndex	= 1;
    pageIndex	= 1;

	// Collect all level_scene structs
    var sceneKeyArray = struct_get_names(global.dialogBuckets);

	// Parse keys
    for (var i = 0; i < array_length(sceneKeyArray); i++) {
        var key			= sceneKeyArray[i];			// e.g. "1_1"
        var parts		= string_split(key, "_");	// split key (1_1) to individual strings
        var kLevel		= real(parts[0]);			// current level
        var kScene		= real(parts[1]);			// current scene
		var sceneString = string(kScene);
		
		// If current level is correct, organize scene as scene Struct > box struct > page struct > line entry array
        if (kLevel == level) {
			// References data read by obj_script
            var sceneDataStruct = global.dialogBuckets[$ key];
			var posData = global.textboxCoordinates[$ key];
			
			// If the level_scene bucket doesn't exist, add it
            if (!struct_exists(dialogData, sceneString)) {
                dialogData[$ sceneString] = {};
            }
            positionData[$ key] = posData;

			// References local structs in obj_textEngine
            var sceneStruct = dialogData[$ sceneString];

			// Collect box data structs within the level_scene struct from dialog buckets
            var boxKeysArray = struct_get_names(sceneDataStruct);
			
			// Loop over each box data struct in the level_scene data struct
            for (var b = 0; b < array_length(boxKeysArray); b++) {
                var boxKey			= boxKeysArray[b]; 
                var boxDataStruct = sceneDataStruct[$ boxKey]; 
				var pagesKeysArray	= struct_get_names(boxDataStruct);

                // If the box struct doesn't exist, add it
                if (!struct_exists(sceneStruct, boxKey)) {
                    sceneStruct[$ boxKey] = {};
                }
                var boxStruct = sceneStruct[$ boxKey];

                // Loop over each page data struct in boxDataStruct
                for (var l = 0; l < array_length(pagesKeysArray); l++) {
                    var pageKey = pagesKeysArray[l];
					var linesDataArray = boxDataStruct[$ pageKey];
					
					// If this page doesn't exist yet under boxStruct, create an empty array
                    if (!struct_exists(boxStruct, pageKey)) {
                        boxStruct[$ pageKey] = [];
                    }
                    var pageArray = boxStruct[$ pageKey];

                    // Add the line entry
					for (var m = 0; m < array_length(linesDataArray); ++m) {
					    array_push(pageArray, linesDataArray[m]);
					}
                }
            }
        }
    }
}