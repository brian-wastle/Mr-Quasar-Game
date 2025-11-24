if (shelvesLength != 0) {
	// go backwards through the active shelves, and rotate each one unless it overlaps the next
	for (var index = shelvesLength - 1; index >= 0; --index) {  
	    var inst = shelves[index];
	    if (instance_exists(inst)) {
	        with (inst) {
	            event_user(0);
	        }
	    } else {
			array_delete(shelves,index,1);
			shelvesLength = array_length(shelves);
		}
	}
} else {
	instance_destroy();
}