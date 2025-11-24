//if (keyboard_check_pressed(ord("P")))
//{
//    zoomIndex  = (zoomIndex + 1) mod array_length(zoomLevels);
//    targetZoom = zoomBase * zoomLevels[zoomIndex];
//}

if (instance_exists(targetObj)) {
	// Fixed or moving camera
	if (!cutscene && targetObj != noone) {
	    // Follow player horizontally
	    targetPos.xPos = round(targetObj.x / 4) * 4;
		// Clamp vertically
		targetPos.yPos = yFixed;   
	} else if (targetObj != noone) {
	    targetPos.xPos = round(targetObj.x / 4) * 4;
	    targetPos.yPos = round(targetObj.y / 4) * 4;
	}


	// Pan & Zoom
	x         = round((x +  (targetPos.xPos - x) / smoothPos)   / 4) * 4;
	y         = round((y +  (targetPos.yPos - y) / smoothPos)   / 4) * 4;
	zoom     +=        (targetZoom - zoom) / smoothZoom;
	drawOffset +=      (drawOffsetT - drawOffset) / smoothScreen;


	// Update letter‑box height
	barCurrent = lerp(barCurrent, barTarget, barSpeed);
	if (abs(barCurrent - barTarget) < 0.5)
	    barCurrent = barTarget;

	// Push to view #0
	camera_set_view_size(view_camera[0], camWidth, camHeight);

	var offW = ((camWidth  / zoom) - camWidth)  * 0.5;
	var offH = ((camHeight / zoom) - camHeight) * 0.5;

	camera_set_view_pos(
	    view_camera[0],
	    x - camWidth  * 0.5 - offW,
	    y - camHeight * 0.5 - offH);
	
} else {
	targetObj = noone;
}