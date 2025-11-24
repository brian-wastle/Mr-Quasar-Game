// Grab the CSV
var filePath = "comeawaydeath.csv";

if (file_exists(filePath)) {
    var fileId = file_text_open_read(filePath);
    file_text_readln(fileId); // Read header

    // Global dialogBuckets: struct of structs
    global.dialogBuckets = {};

    while (!file_text_eof(fileId)) {
        var lineString = file_text_readln(fileId);
        var columns = string_split(lineString, ",");
		if (array_length(columns) > 6) {
		    var tail = columns[5];                    // start with field 6
		    for (var i = 6; i < array_length(columns); ++i) {
		        tail += "," + columns[i];             // put the commas back
		    }
		    columns[5] = tail;                        // store rebuilt Dialogue
		    array_resize(columns, 6);                 // discard extra slots
		}
        var level     = real(columns[0]);
        var scene     = real(columns[1]);
        var box       = real(columns[2]);
        var page      = real(columns[3]);
        var character = columns[4];
        var dialogRaw = string_replace_all(columns[5], "\"", "");
		//Data Structures within dialogBuckets
        var sceneKey = string(level) + "_" + string(scene);
        var boxKey = string(box);
		var pageArray = string(page);

        // Create line entry struct
        var entry = {
            page: page,
            character: character,
            dialogRaw: dialogRaw
        };

        // If the level_scene bucket doesn't exist, add it
        if (!struct_exists(global.dialogBuckets, sceneKey)) {
            global.dialogBuckets[$ sceneKey] = {};
        }

        var sceneStruct = global.dialogBuckets[$ sceneKey];

        // If the box struct doesn't exist, add it
        if (!struct_exists(sceneStruct, boxKey)) {
		    sceneStruct[$ boxKey] = {};
		}

       var boxStruct = sceneStruct[$ boxKey];
	   // If the page array doesn't exist, add it
	   if (!is_array(boxStruct[$ pageArray])) {
	       boxStruct[$ pageArray] = [];
	   }
	   
	   array_push(boxStruct[$ pageArray],entry)
	   
    }

    file_text_close(fileId);

} else {
    show_error("comeawaydeath.csv not found...?", true);
}


// Read textbox coordinates
// Grab the CSV
var filePath2 = "forjoveuncurtaindheaven.csv";

if (file_exists(filePath2)) {
	var fileId2 = file_text_open_read(filePath2);
	file_text_readln(fileId2); // Read header

	// Global dialogBuckets: struct of structs
	global.textboxCoordinates = {};

	while (!file_text_eof(fileId2)) {
		var lineString2 = file_text_readln(fileId2);
		var columns2 = string_split(lineString2, ",");

		var level		= real(columns2[0]);
		var scene		= real(columns2[1]);
		var boxIndex	= real(columns2[2]);
		var xPos		= real(columns2[3]);
		var yPos		= real(columns2[4]);
		//Data Structures within dialogBuckets
		var sceneKey = string(level) + "_" + string(scene);
		var boxKey = string(boxIndex);

		// Create line entry struct
		var entry = {
			boxIndex: boxIndex,
			xPos: xPos,
			yPos: yPos
		};

		// If the level_scene bucket doesn't exist, add it
		if (!struct_exists(global.textboxCoordinates, sceneKey)) {
			global.textboxCoordinates[$ sceneKey] = [];
		}

		var boxArray = global.textboxCoordinates[$ sceneKey];
		array_push(boxArray,entry)
	}

    file_text_close(fileId2);

    // Create the text engine
    instance_create_layer(x, y, "Instances", obj_textEngine);

} else {
    show_error("forjoveuncurtaindheaven.csv not found...?", true);
}