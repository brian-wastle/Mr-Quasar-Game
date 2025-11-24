if (image_index < image_number - 1) {
	image_index = (((100 - enemyHealth)/10)/10) * image_number
} 

if (image_index >= image_number -.5) {
	image_index = image_number -.5;
}


event_inherited();