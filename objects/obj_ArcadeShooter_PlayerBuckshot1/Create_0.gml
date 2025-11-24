direction = point_direction(x, y, destinationX, destinationY);
depth = -299;
initialX = x;
initialY = y;
initPathDist = pathDistance;


//create 9 buckshot and fire them off in a cone
function shootBuckshot(spread, shotSpeed) {
    // Number of shots
    numShots = 9;
    bulletSpeed = initPathDist/shotSpeed;
    // Calculate the angle offset for each shot within the cone
	spreadProjection = spread / (initPathDist/1800);
    halfSpread = spreadProjection / 2;
    angleStep = spreadProjection / (numShots - 1);
    
    for (var i = 0; i < numShots; i++) {
        // Calculate the direction for each shot
        shotDirection = direction - halfSpread + (i * angleStep);
        
        // Create an instance of obj_arcadeShooter_singleBuckshot with direction and speed
        shot = instance_create_layer(x, y,"Instances", obj_arcadeShooter_singleBuckshot, {
            direction: shotDirection,
            speed: bulletSpeed
        });
    }
};

shootBuckshot(20,10);