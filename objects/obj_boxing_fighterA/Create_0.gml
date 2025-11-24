spriteArray = [spr_boxing_fighterA_bgL, spr_boxing_fighterA_bgC, spr_boxing_fighterA_bgR];
playerDir = 0;

// Define state variables
isSliding = false; // Whether the object is in the sliding state
slideStartTime = 0; // The time when sliding started (initialize to 0)
switchDuration = 2.5; // Duration to continue sliding in seconds
offsetDistance = 400; // Distance to maintain from the player
triggerDistance = 300; // Distance to trigger sliding
slideSpeed = 0.02; // Adjust this value for smoother sliding
trackSpeed = 0.005; // Adjust this value for smoother tracking when outside offsetDistance
targetSlidingX = 0; // Initialize target position for sliding
playerMovingToward = 0;
playerMovingAway = 0;

player_near_left_edge = 0;
player_near_right_edge = 0;
screenBuffer = 500;