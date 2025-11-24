x += hspeed;
if (y < floorY) {
    y += vspeed;
	vspeed += g;                 // gravity (pulls it back down slowly)
}


scale += growth;
alpha  = 1 - age / lifetime;

image_xscale = image_yscale = scale;
image_alpha  = alpha;

age++;
if (age >= lifetime) instance_destroy();