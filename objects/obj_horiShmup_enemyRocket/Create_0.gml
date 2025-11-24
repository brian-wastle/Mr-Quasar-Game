currentView = view_camera[0];
x1 = camera_get_view_x(currentView);
y1 = camera_get_view_y(currentView);
x2 = x1 + camera_get_view_width(currentView);
y2 = y1 + camera_get_view_height(currentView);
centerX = x1 + ((x2-x1)/2);
centerY = y1 + ((y2-y1)/2);


enemyEventTimer = 0;
image_speed = .8;

blinkVar = 0;
enemyHealth = 100;

collisionList = 0;
bulletList = ds_list_create();