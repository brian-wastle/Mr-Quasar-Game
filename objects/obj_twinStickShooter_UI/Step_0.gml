camView = view_camera[0];
x = camera_get_view_x(camView) + 100;
y = camera_get_view_y(camView) + 58;
currentHealth = obj_TwinStickShooter_player.playerHealth;
heartIndex = 10 - floor(currentHealth/10);
bulletType = obj_TwinStickShooter_player.bulletType;
