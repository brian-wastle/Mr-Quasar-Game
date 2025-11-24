
// Each entry contains :
// charSpeed: real
// charIndex: real
// effect : real
// xOffset:real
// color: hex/real

//currentCharIndex	= 0;		Tracks current character position to be typed
//typeDelay			= 0;		Delay between characters being typed, held in formatted data struct
//typeTimer			= 0;		Tracks current delay timer


// account for the length of each line then switch to the next line
// at the end of the line, switch to the next line
switch (textboxState) {
    case TEXTBOX_STATE.APPEAR: // expanding textbox
		if (cx < 1) {
			cx += 1 / (textboxSpeed * 10);
			cy = animcurve_channel_evaluate(channelAppear, cx);
		    currentXSize = cy * totalWidth;
			currentYSize = cy * totalHeight;
		} else {
			textboxState = TEXTBOX_STATE.TYPE;
		}
        break;
	case TEXTBOX_STATE.TYPE: // typing
		if (keyboard_check(vk_space)) {
		    typeDelay = 0;
			currentCharIndex += 1;
		}
        if (currentCharIndex < charCount && currentLine < totalLines) {
		   if (typeTimer < typeDelay) {
			    typeTimer += 1;
			} else {
				typeTimer = 0;
				typeDelay = getTypeDelay();
				currentCharIndex += 1;
			}
		} else if (currentCharIndex >= charCount && currentLine < totalLines - 1) {
			currentLine += 1;
			currentCharIndex = 0;
			charCount = getCharCount(currentPage, currentLine);
		} else if (currentCharIndex >= charCount && currentLine >= totalLines - 1){
			textboxState = TEXTBOX_STATE.PAUSE;
		}
        break;
	case TEXTBOX_STATE.PAUSE: // waiting on player input
		if (keyboard_check_pressed(vk_space)) {
		    if (currentPage < totalPages - 1) {

		        /* ------------ advance to the next page ------------ */
		        currentPage      += 1;
		        currentLine       = 0;
		        currentCharIndex  = 0;

		        /* ------------- recalc page metrics ---------------- */
		        var newPageData   = getPageData(currentPage);
		        lineKeyArray      = struct_get_names(newPageData);
		        totalLines        = array_length(lineKeyArray);
		        lineLength        = getLinePixelLength();   // longest line on *new* page
		        totalWidth        = lineLength + 64;
		        totalHeight       = (totalLines * 36) + 36;

		        /* ------------- set up the resize ------------------ */
		        startW            = currentXSize;
		        startH            = currentYSize;
		        targetW           = totalWidth;
		        targetH           = totalHeight;

		        resizeProgress    = 0;							// reset timer
		        textboxState = TEXTBOX_STATE.RESIZE;			// NEW resize state
		    }
		    else textboxState = TEXTBOX_STATE.SHRINK;			// final shrink
		}
        break;
	case TEXTBOX_STATE.RESIZE:  // resizing between pages
	    if (resizeProgress < 1) {
	        // advance just like cx in state 0
	        resizeProgress += 1 / (textboxSpeed * 10);
	        var curveVal   = animcurve_channel_evaluate(channelAppear, resizeProgress);

	        // ease from start → target using the SAME curve
	        currentXSize   = lerp(startW, targetW, curveVal);
	        currentYSize   = lerp(startH, targetH, curveVal);
	    } else {
	        // snap & resume typing
	        currentXSize   = targetW;
	        currentYSize   = targetH;

	        charCount      = getCharCount(currentPage, currentLine);
	        typeDelay      = getTypeDelay();
	        textboxState   = TEXTBOX_STATE.TYPE;               // back to typing
	    }
		break;
	case TEXTBOX_STATE.SHRINK: // shrinking textbox
        if (currentXSize > 0) {
			shrinkSpeed *= 1.05;
		    currentXSize -= shrinkSpeed;
			currentXSize = clamp(currentXSize,0,totalWidth);
			var xProgress = currentXSize/totalWidth;
			var tempYHeight = xProgress * totalHeight;
			currentYSize = round(tempYHeight);
		} else {
			instance_destroy();
		}
        break;
	
}

// Text effects
if (wavyDelay < 4) {
    wavyDelay += 1;
} else {
	if (wavyIndex < array_length(wavyArray) - 1) {
	    wavyIndex += 1;
	} else {
		wavyIndex = 0;
	}
	wavyDelay = 0;
}

