var playerNearRightEdge = obj_boxing_fighterB.playerNearRightEdge;
var playerNearLeftEdge = obj_boxing_fighterB.playerNearLeftEdge;
var playerState = obj_boxing_fighterB.playerState;
var backgroundSpeed = obj_boxing_fighterB.backgroundSpeed;
var targetSpeed = obj_boxing_fighterB.targetSpeed;

if ((playerNearLeftEdge || playerNearRightEdge) || playerState = 1) {
	scrollSpeed = -backgroundSpeed - targetSpeed;
	scrollOffset += scrollSpeed;
} else {
	scrollSpeed = (backgroundSpeed = 0 ? -targetSpeed : backgroundSpeed + targetSpeed);
	scrollOffset += scrollSpeed;
}

if (scrollOffset <= -imageSpacing) {
    scrollOffset += imageSpacing;
    currentIndex = (currentIndex + 1) mod imageCount;
}

if (scrollOffset >= imageSpacing) {
    scrollOffset -= imageSpacing;
    currentIndex = (currentIndex - 1 + imageCount) mod imageCount;
}