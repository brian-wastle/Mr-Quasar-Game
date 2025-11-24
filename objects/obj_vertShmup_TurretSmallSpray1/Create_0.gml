playerDirection = 0; //direction to player
shotDirection = 0; // direction of bullet
shotOffset = 0; // add spread effect to bullets
offsetMax = 5; // how far of a spread
clipCapacity = 20; // how many bullets at a time
reloadAmount = 20;
bulletInterval = 60; // how long in between shots
bulletTimer = 0; //handles timer for bulletInterval
shootingState = 0; //whether gun is shooting
bulletSpeed = 4; //speed of bullets
intervalIndex = 0; //keeps track of index for array containing firing pattern

//intervals = [] // bullet timing pattern