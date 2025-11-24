var playerNearRightEdge = obj_boxing_fighterB.playerNearRightEdge;
var playerNearLeftEdge = obj_boxing_fighterB.playerNearLeftEdge;
var playerState = obj_boxing_fighterB.playerState;
var backgroundSpeed = obj_boxing_fighterB.backgroundSpeed;
var targetSpeed = obj_boxing_fighterB.targetSpeed;

if ((playerNearLeftEdge || playerNearRightEdge) || playerState == 1) {
    scrollSpeed = -backgroundSpeed - targetSpeed;
    scrollOffset += scrollSpeed;
} else {
    scrollSpeed = (backgroundSpeed == 0 ? -targetSpeed : backgroundSpeed + targetSpeed);
    scrollOffset += scrollSpeed;
}

// Wrap scroll offset
if (scrollOffset <= 0) {
    scrollOffset += imageSpacing;
}
if (scrollOffset >= imageSpacing) {
    scrollOffset -= imageSpacing;
}

// Calculate grid positions around each anchor coordinate
var imageY = 250;
var gridCols = 3;
var gridRows = 2;
var gridSpacing = 100;
var anchors = [
    scrollOffset,
    scrollOffset + imageSpacing,
    scrollOffset - imageSpacing
];

gridPositions = [];
gridRotations = [];

var roomCenterX = room_width / 2;
var maxRotation = 15;
var maxLift = 50;

for (var a = 0; a < array_length(anchors); a++) {
    var anchorX = anchors[a];
    var rotation = ((anchorX - roomCenterX) / roomCenterX) * maxRotation;
	 lift = maxLift * (1 - sqr((anchorX - roomCenterX) / roomCenterX));
	
    for (var row = 0; row < gridRows; row++) {
        for (var col = 0; col < gridCols; col++) {
            var gridX = (col - floor(gridCols / 2)) * gridSpacing;
            var gridY = (row - floor(gridRows / 2)) * gridSpacing;

            var rotatedX = anchorX + gridX * dcos(rotation) - gridY * dsin(rotation);
            var rotatedY = (imageY + gridX * dsin(rotation) + gridY * dcos(rotation)) - lift;

            array_push(gridPositions, [rotatedX, rotatedY]);
            array_push(gridRotations, rotation);
        }
    }
}