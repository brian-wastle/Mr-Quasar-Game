if (image_index == image_number - 1) {
    instance_destroy();
}
if (image_index > 12 && pickupID == noone) {
    pickupID = instance_create_layer(x, y, "Instances", obj_runAndGun_sniperPickup);
}