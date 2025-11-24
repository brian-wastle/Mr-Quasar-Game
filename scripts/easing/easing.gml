
function easeInXAxis(argument0, argument1, argument2, argument3, argument4, argument5) {
	var startPoint = argument0;
	var endPoint = argument1;
	var n = argument2;
	var easeInX = argument3; // distance between beginning of curve, and when it reaches max curvature
	var easeOutX = argument4; // how far from the end of the turn to begin easing out
	var maxCurve = argument5; // max curvature
	var curveProgress;
	
	if (n <= startPoint + easeInX) {
		var distanceToStart = n - startPoint;
        curveProgress = maxCurve * (distanceToStart / easeInX) * (distanceToStart / easeInX);
	} else {
		curveProgress = maxCurve;
	}
	
	if (n >= endPoint - easeOutX) {
		curveProgress = maxCurve * ((endPoint - n) / (easeOutX)) * ((endPoint - n) / (easeOutX));
	}
	

	return curveProgress;
	
}

function easeInYAxis(argument0, argument1, argument2, argument3, argument4, argument5, argument6) {
	var startPoint = argument0;
	var endPoint = argument1;
	var n = argument2;
	var targetElevationTemp = argument3; // previous elevation
	var easeInY = argument4; //distance of easing in
	var easeOutY = argument5; //distance of easing out
	var totalElevationChange = argument6; // change in elevation
	var newElevation = 0;

	
	if (n <= startPoint + easeInY) {
		newElevation = totalElevationChange * ((n-startPoint) / easeInY) * ((n-startPoint) / easeInY) 
	} else {
		newElevation = totalElevationChange;
	}
	
	if (n >= endPoint - easeOutY) {
		newElevation = totalElevationChange * ((endPoint - n) / (easeOutY)) * ((endPoint - n) / (easeOutY))
	}
	newElevation = targetElevationTemp + newElevation;
	return newElevation;
	
}