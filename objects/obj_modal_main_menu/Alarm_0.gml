// Only load data if it hasn't already been loaded
if (!global.data_loaded) {
	
	
    global.wordArray = load_json_file("wordArray.json");
    global.wordOrder = load_json_file("wordOrder.json");
    global.wordObj = load_json_file("wordObj.json");
	

    if (global.wordArray != undefined && global.wordObj && global.wordOrder != undefined) {
        global.data_loaded = true;  // Set the flag to true to prevent reloading
        show_debug_message("Data loaded successfully.");
    } else {
        show_debug_message("Error: Failed to load one or more JSON files.");
    }
}