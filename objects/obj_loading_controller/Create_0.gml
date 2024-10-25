// obj_loading_controller Create Event
global.data_loaded = false;

// Start a small delay to ensure loading screen is drawn
alarm[0] = 3;

function load_game_data() {
    // Load JSON files
    global.wordArray = load_json_file("wordArray.json");
    global.wordOrder = load_json_file("wordOrder.json");
    global.wordObj = load_json_file("wordObj.json");
    
    if (global.wordArray != undefined && 
        global.wordObj != undefined && 
        global.wordOrder != undefined) {
        
        global.data_loaded = true;
        show_debug_message("Data loaded successfully.");
        
        // Add a small delay before transitioning to menu
        alarm[1] = 30; // 0.5 seconds at 60fps
    } else {
        show_debug_message("Error: Failed to load one or more JSON files.");
        // Handle error - maybe show error message and retry button
    }
}