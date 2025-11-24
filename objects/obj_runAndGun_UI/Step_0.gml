
// Set player id
player = player == noone && instance_exists(obj_RunAndGun_Player) ? obj_RunAndGun_Player.id : noone;

if (player != noone) {
	setHearts();
	bulletType = obj_RunAndGun_Player.weaponType;
}