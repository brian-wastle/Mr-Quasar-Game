depth = 175;
xOrigin = x;
yOrigin = y;


// Initialize variables
currentTime = 0;
pendulumActive = false;
swinging = false;  // Track if the pendulum is actively swinging
swingCount = 0;    // Counter for swings
pendulumSpeed = 0; // Initial angular velocity

// Function to initialize pendulum from 90 degrees to 0 degrees
function startPendulum() {
    if (!pendulumActive) {
        targetAngle = choose(10, -10);
        image_angle = lerp(image_angle, targetAngle, 0.2);  
        pendulumActive = true;  
		x -= 12;
		bumpTrigger = 1;
    }
}

function pendulumSwing() {
    var maxDisplacement = 10;
    var grav = 0.7;
    var dampingFactor = 0.96;
    var totalSwings = 3;
	if (bumpTrigger == 1) {
	x = xOrigin;
	y = yOrigin;
	bumpTrigger = 0;
	}
    if (pendulumActive) {
        var prev_angle = image_angle;
        var acceleration = -grav * sin(degtorad(image_angle));
        pendulumSpeed += acceleration;
        pendulumSpeed *= dampingFactor;
        image_angle += pendulumSpeed;
        if (swingCount == 0 && (image_angle >= maxDisplacement || image_angle <= -maxDisplacement)) {
            swingCount++;
        }
        if ((prev_angle < 0 && image_angle >= 0) || (prev_angle > 0 && image_angle <= 0)) {
            swingCount++;  
            if (swingCount >= totalSwings * 2) {
                pendulumActive = false;
				swingCount = 0;
            }
        }
    } else {
        image_angle = lerp(image_angle, 0, 0.1);
        if (abs(image_angle) < 0.01) {
            image_angle = 0;
            pendulumSpeed = 0;
        }
    }
}

