var currentView = view_camera[0];
var x1 = camera_get_view_x(currentView);
var y1 = camera_get_view_y(currentView);
var x2 = x1 + camera_get_view_width(currentView);
var y2 = y1 + camera_get_view_height(currentView);
if (!point_in_rectangle( x, y, x1, y1, x2, y2)) { 
	instance_destroy(); 
}


//homing bullets
if (instance_exists(obj_horiShmup_player) && homingVar = 1) {
	if (instance_exists(nearestEnemyInst)) {
		//compare direction to nearest enemy
		var dir, diff;
	    dir  = point_direction( x, y, nearestEnemyInst.x, nearestEnemyInst.y );
	    diff = angle_difference( dir, direction );
   
	    if ( abs(diff) < 10 )
	        direction = dir;
	    else
	        direction += sign(diff) * 10;
		
	
		//change direction positive or negative based on direction to enemy
		//direction = direction + ;
	}
}


