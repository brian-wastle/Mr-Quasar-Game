local = undefined;      // { dx, dy, half_w, h }
owner = noone;

prev_x = x;
prev_y = y;
prev_angle = image_angle;

motion_dx = 0;
motion_dy = 0;
motion_da = 0;

surface_x1 = x;
surface_y1 = y;
surface_x2 = x;
surface_y2 = y;

surface_prev_x1 = x;
surface_prev_y1 = y;
surface_prev_x2 = x;
surface_prev_y2 = y;

surface_normal_x = 0;
surface_normal_y = -1;
surface_tangent_x = 1;
surface_tangent_y = 0;

surface_mid_x = x;
surface_mid_y = y;

pivot_x = x;
pivot_y = y;

step_tick = current_time;
basis_cos = 1;
basis_sin = 0;

