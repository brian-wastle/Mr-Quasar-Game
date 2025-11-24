// Ensure the player and target object exist
if (instance_exists(obj_boxing_fighterB) && instance_exists(obj_boxing_fighterA)) {

    var player_x = obj_boxing_fighterB.x;
    var player_y = obj_boxing_fighterB.y;
    var target_x = obj_boxing_fighterA.x;
    var target_y = obj_boxing_fighterA.y;

    // Calculate the midpoint between the player and the target
    var midpoint_x = (player_x + target_x) / 2;
    var midpoint_y = (player_y + target_y) / 2;

    // Define the smoothing speed for the camera
    var camera_speed = 0.1; // Adjust this value for more/less smoothness

    // Update camera's position with a lerp towards the midpoint
    x = lerp(x, midpoint_x, camera_speed);
    y = lerp(y, midpoint_y, camera_speed);

    // Set the camera position based on this object's coordinates
    camera_set_view_pos(view_camera[0], x - (camera_get_view_width(view_camera[0]) / 2), y - (camera_get_view_height(view_camera[0]) / 2));
}
