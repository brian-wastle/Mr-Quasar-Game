//draw_text(x - 1000, y + 150, textboxState);
//draw_text(x - 1000, y + 200, typeTimer);
//draw_text(x - 1000, y + 225, typeDelay);
//draw_text(x - 1000, y + 300, currentLine);
//draw_text(x - 1000, y + 350, totalLines);
//draw_text(x - 1000, y + 450, currentCharIndex);
//draw_text(x - 1000, y + 500, charCount);

// draw textbox bg
draw_set_color(#A8A8A8);
var halfSizeX = currentXSize/2;
var halfSizeY = currentYSize/2;
draw_set_alpha(.8);
draw_rectangle(initialXPos - halfSizeX, initialYPos - halfSizeY, initialXPos + halfSizeX, initialYPos + halfSizeY, 0);
draw_set_alpha(1);
draw_set_color(c_white);

// draw textbox border corners
draw_sprite_ext(spr_textbox_outlineCorners, 0, initialXPos - halfSizeX, initialYPos - halfSizeY, 1, 1, 0, c_white, 1);
draw_sprite_ext(spr_textbox_outlineCorners, 1, initialXPos - halfSizeX, initialYPos + halfSizeY, 1, 1, 0, c_white, 1);
draw_sprite_ext(spr_textbox_outlineCorners, 2, initialXPos + halfSizeX, initialYPos - halfSizeY, 1, 1, 0, c_white, 1);
draw_sprite_ext(spr_textbox_outlineCorners, 3, initialXPos + halfSizeX, initialYPos + halfSizeY, 1, 1, 0, c_white, 1);

// vertical bars
var tempHeight = (initialYPos + halfSizeY) - (initialYPos - halfSizeY);
draw_sprite_stretched(spr_textbox_edgesVertical, 0, initialXPos - halfSizeX - 12, initialYPos - halfSizeY, 12, tempHeight);
draw_sprite_stretched(spr_textbox_edgesVertical, 0, initialXPos + halfSizeX, initialYPos - halfSizeY, 12, tempHeight);

// horizontal bars
var tempWidth = (initialXPos + halfSizeX) - (initialXPos - halfSizeX);
draw_sprite_stretched(spr_textbox_edgesHorizontal, 0, initialXPos - halfSizeX, initialYPos - halfSizeY - 12, tempWidth, 12);
draw_sprite_stretched(spr_textbox_edgesHorizontal, 0, initialXPos - halfSizeX, initialYPos + halfSizeY, tempWidth, 12);

// draw tail


// draw text
if (textboxState > 0 && textboxState < 3) {
	// currentCharIndex is the current character being typed, draw the characters in formatted struct up to currentCharIndex
	var thisPageData = getPageData(currentPage);
	var lineKeys = struct_get_names(thisPageData);
	var lineCount = array_length(lineKeys);
	var xStart = initialXPos - lineLength/2; // left margin of text box
	xStart = round(xStart / 4) * 4;

	// loop over each line
	for (var i = 0; i < lineCount; ++i) {
		var lineString = string(i + 1);
		var thisLineData = thisPageData[$ lineString];
		var charTotal = getCharCount(currentPage, i);
		var lineXOffset = 0; // reset x offset position before each line
		// loop over character entry array in formattedStruct
		for (var j = 0; j < charTotal; ++j) {
			var thisEntry = thisLineData[j];
			var waveOffset = 0;
			if (thisEntry.effect = "Wavy") {
				var wavyJ = array_length(wavyArray) - 1 - ((wavyIndex + j) % array_length(wavyArray));
			    waveOffset = wavyArray[wavyJ];
			}
		    if (thisEntry.lineIndex < currentLine) {
			    // if char's lineIndex is less than i, draw the character
				draw_sprite_ext(spr_font, thisEntry.charIndex, xStart + lineXOffset, initialYPos - halfSizeY + 24 + ( 36 * i) + waveOffset, 1, 1, 0, thisEntry.charColor, 1);
				lineXOffset = thisEntry.xOffset;
			} else if ((thisEntry.lineIndex == currentLine && j <= currentCharIndex) || textboxState == 2) {
				// else, if the array index is less than current char index, draw the character
				draw_sprite_ext(spr_font, thisEntry.charIndex, xStart + lineXOffset, initialYPos - halfSizeY + 24 + ( 36 * i) + waveOffset, 1, 1, 0, thisEntry.charColor, 1);
				lineXOffset = thisEntry.xOffset;
			}
		}
	}
	
// draw button prompt
	if (textboxState == 2) {
	    draw_sprite_ext(spr_textbox_pointer, pointerIndex, initialXPos + halfSizeX - 4, initialYPos + halfSizeY - 4, 1, 1, 0, c_white, 1);
	}
}