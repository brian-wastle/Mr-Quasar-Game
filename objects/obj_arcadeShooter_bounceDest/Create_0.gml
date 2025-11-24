
enemyHealth = 10;
ySpeed = -15;
floorY = y + offset;
effectsTrigger = 0;
image_speed = 0;

var t = (x - 200) / 2000; // Calculate interpolation factor t (0 to 1)
var a = lerp(0, -5, t);  // Interpolate a from 0 to -5
var b = lerp(5, 0, t);   // Interpolate b from 5 to 0
a = clamp(a, 0, -5);
b = clamp(b, 0, 5);

xSpeed = irandom_range(a,b);

if !variable_instance_exists(id, "objectType")
{
    objectType = 0;
}


