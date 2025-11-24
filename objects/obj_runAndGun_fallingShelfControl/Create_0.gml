shelves = [];
shelvesLength = 0;
for (var i = 0; i < 4; ++i) {
    shelves[i]= instance_create_layer(
		7440 + (688 * i), 1080, "ShelvesRear", obj_runAndGun_fallingShelfRear
	);
}
shelvesLength = array_length(shelves);