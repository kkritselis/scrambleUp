// Only load data if it hasn't already been loaded
if (!global.data_loaded) {
	
	if (file_exists("wordObj.json")) {
		show_debug_message("wordObj file found.");
	} else {
		show_debug_message("wordObj file not found.");
	}

	if (file_exists("wordArray.json")) {
		show_debug_message("wordArray file found.");
	} else {
		show_debug_message("wordArray file not found.");
	}
	
    global.wordArray = load_json_file("wordArray.json")
	if (global.wordArray != undefined) {
		show_debug_message("wordArray loaded successfully.");
	} else {
		show_debug_message("Failed to load wordArray.json.");
	}
    global.wordObj = load_json_file("wordObj.json");
	if (global.wordObj != undefined) {
		show_debug_message("wordObj loaded successfully.");
	} else {
		show_debug_message("Failed to load wordObj.json.");
	}
	

    if (global.wordArray != undefined && global.wordObj != undefined) {
        global.data_loaded = true;  // Set the flag to true to prevent reloading
        show_debug_message("Data loaded successfully.");
    } else {
        show_debug_message("Error: Failed to load one or more JSON files.");
    }
}