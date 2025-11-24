depth = 750;
if (!variable_instance_exists(id, "ground")) ground = false;


// ---------- SHARED ----------
lifetime = irandom_range(32, 44);     // ½–¾ s
age      = 0;
scale    = 1;
growth   = 0.045;
alpha    = 1;

// ---------- BRANCH ----------
if (ground) {
    // stays close to the floor, wafts sideways
    hspeed = random_range(-1.2,  1.2);
    vspeed = random_range(-0.3,  0.0);   // almost flat
    g      = 0.15;                       // pulls it down quickly
    growth = 0.030;                      // grows more slowly
	floorY = y;
} else {
    // rising smoke (unchanged from last answer)
    hspeed = random_range(-0.4,  0.4);
    vspeed = random_range(-3.0, -.3);
    g      = 0.06;
	floorY = 0;
}