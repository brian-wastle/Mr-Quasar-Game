switch(async_load[? "event_type"]) {         // Parse the async_load map to see which event has been triggered
	case "gamepad discovered":                     // A game pad has been discovered
	    global.pad = async_load[? "pad_index"];       // Get the pad index value from the async_load map
	    gamepad_set_axis_deadzone(global.pad, 0.2);       // Set the "deadzone" for the axis
	    gamepad_set_button_threshold(global.pad, 0.1);    // Set the "threshold" for the triggers
	    break;
	case "gamepad lost":                           // Gamepad has been removed or otherwise disabled
	    global.pad = async_load[? "pad_index"];       // Get the pad index
	    break;
}