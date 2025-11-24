var distanceToExplosion = point_distance(x, y, other.x, other.y);
if (owner.pushDistance = 0) {
	owner.pushDistance = max(0, 200 - distanceToExplosion);
	if (owner.pushDistance > 0) {
	    owner.pushDirection = point_direction(x, y, other.x, other.y);
	} else {
		owner.pushDirection = irandom(360);
	}
}

if (damageTimer >= 30) {
	owner.enemyHealth -= 32;
	damageTimer = 0;
}
