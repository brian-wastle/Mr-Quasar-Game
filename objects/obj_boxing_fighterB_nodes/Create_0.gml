currentSpeed = 0;
targetSpeed = 0;
accel = 1.4;
childSpeed = 0;

childNode = (node == "arm") ? 
	instance_create_layer(
		x,
		y,
		"Arms",
		obj_boxing_fighterB_arm, {
			parentId: id,
		}
	) : ((node == "gloveRight") ? instance_create_layer(
		x,
		y,
		"Arms",
		obj_boxing_fighterB_gloveRight, {
			parentId: id
		}
	): instance_create_layer(
		x,
		y,
		"Arms",
		obj_boxing_fighterB_gloveLeft, {
			parentId: id
		}
	)
);