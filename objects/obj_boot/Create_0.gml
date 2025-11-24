if (!instance_exists(obj_init_textureGroups))  instance_create_layer(0,0,"Instances", obj_init_textureGroups);
if (!instance_exists(obj_controllerobj)) instance_create_layer(0,0,"Instances", obj_controllerobj);

with (obj_init_textureGroups) {
    goToRoomViaLoader(rm_pressStart);
}

instance_destroy();