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
         alarm[1] = 10;//0.1 seconds at 60fps
     } else {
         show_debug_message("Error: Failed to load one or more JSON files.");
         // Handle error - maybe show error message and retry button
     }
 }


 function load_json_file(fileName) {
	
     var file = file_text_open_read(fileName); // No need for "datafiles/" prefix
     if (file == -1) {
         show_debug_message("Error: Could not open file '" + fileName + "'");
         return undefined;
     }
    
     var fileText = "";
     while (!file_text_eof(file)) {
         fileText += file_text_read_string(file);
         file_text_readln(file); // Move to next line
     }
     file_text_close(file);
    
     return json_parse(fileText);
 }

