if (!instance_exists(owner)) { instance_destroy(); exit; }

var last_x = prev_x;
var last_y = prev_y;
var last_angle = prev_angle;

surface_prev_x1 = surface_x1;
surface_prev_y1 = surface_y1;
surface_prev_x2 = surface_x2;
surface_prev_y2 = surface_y2;

var ang = owner.image_angle;
image_angle = ang;
var c = dcos(ang);
var s = -dsin(ang); // GMS Y-axis is downward, hence the minus
basis_cos = c;
basis_sin = s;

pivot_x = owner.x;
pivot_y = owner.y;

x = owner.x + (local.dx * c - local.dy * s);
y = owner.y + (local.dx * s + local.dy * c);

motion_dx = x - last_x;
motion_dy = y - last_y;
motion_da = angle_difference(ang, last_angle);

prev_x = x;
prev_y = y;
prev_angle = ang;

var edgeLen = local.half_w * 2;     // top edge length (width)
var off = 5;                        // "inside" probe offset

// Platform top edge origin (current mask origin after rotation)
var x0 = x;
var y0 = y;

// Unit tangent along the top edge and unit normal pointing *down* into the shelf
var tx = lengthdir_x(1, ang);
var ty = lengthdir_y(1, ang);
var nx = lengthdir_x(1, ang + 90);
var ny = lengthdir_y(1, ang + 90);

// Top edge endpoints
var x1 = x0;
var y1 = y0;
var x2 = x0 + tx * edgeLen;
var y2 = y0 + ty * edgeLen;

surface_x1 = x1;
surface_y1 = y1;
surface_x2 = x2;
surface_y2 = y2;

surface_normal_x = -nx;
surface_normal_y = -ny;
surface_tangent_x = tx;
surface_tangent_y = ty;

surface_mid_x = (x1 + x2) * 0.5;
surface_mid_y = (y1 + y2) * 0.5;

step_tick = current_time;

with (obj_RunAndGun_Player) {
	if (support_platform == other.id && support_contact) {
		var clearance_prev = support_world_pos.clearance;
		if (clearance_prev <= 48) {
			var loc_x = support_local_pos.x;
			var loc_y = support_local_pos.y;
			var c_new = other.basis_cos;
			var s_new = other.basis_sin;

			var rel_x_new = loc_x * c_new - loc_y * s_new;
			var rel_y_new = loc_x * s_new + loc_y * c_new;

			var world_x = other.pivot_x + rel_x_new;
			var world_y = other.pivot_y + rel_y_new;

			var clearance = clamp(clearance_prev, 0, 4);
			world_x += other.surface_normal_x * clearance;
			world_y += other.surface_normal_y * clearance;

			x = world_x;
			y = world_y;

			if (vsp > 0 && clearance <= 4) {
				vsp = 0;
			}
			if (actionstate == 14 && clearance <= 4) {
				actionstate = 0;
				jumpStatus = max(jumpStatus, 1);
			}

			support_motion.dx = other.motion_dx;
			support_motion.dy = other.motion_dy;
			support_motion.da = other.motion_da;
			support_tick = other.step_tick;
			support_surface_normal.x = other.surface_normal_x;
			support_surface_normal.y = other.surface_normal_y;
			support_surface_tangent.x = other.surface_tangent_x;
			support_surface_tangent.y = other.surface_tangent_y;

			var proj_world_x = world_x - other.surface_normal_x * clearance;
			var proj_world_y = world_y - other.surface_normal_y * clearance;
			support_world_pos.x = proj_world_x;
			support_world_pos.y = proj_world_y;
			support_world_pos.clearance = clearance;

			image_angle = 0;
		}
	}
}

// "Inside" line (a few px below the top surface, into the shelf body)
//var ix1 = x1 + nx * off;
//var iy1 = y1 + ny * off;
//var ix2 = x2 + nx * off;
//var iy2 = y2 + ny * off;

// Player collision checks
//var onTop  = collision_line(x1,  y1,  x2,  y2,  PLAYER, true, true);
//var inside = collision_line(ix1, iy1, ix2, iy2, PLAYER, true, true);
