 function load_game_data() {
     // Load JSON files
    global.wordArray = load_json_buffer("wordArray.json");
	global.wordOrder = load_json_buffer("wordOrder.json");
	global.wordObj = load_json_buffer("wordObj.json");

	if (global.wordArray != undefined && global.wordOrder != undefined && global.wordObj != undefined) {
		global.data_loaded = true;
		show_debug_message("Data loaded successfully.");
		alarm[1] = 10;//0.1 seconds at 60fps
	} else {
		show_debug_message("Error: Failed to load one or more JSON files.");
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

/// @function load_json_buffer(fileName)
/// @description Loads a JSON file using buffers and returns the parsed data.
function load_json_buffer(fileName) 
{
    if (!file_exists(fileName)) {
        show_debug_message("JSON file not found: " + fileName);
        return undefined;
    }

    // Load the entire file into a buffer
    var buf = buffer_load(fileName);
    if (buf == -1) {
        show_debug_message("Failed to load file into buffer: " + fileName);
        return undefined;
    }

    // Get buffer size and read content as a string
    var buf_size = buffer_get_size(buf);
    var jsonString = buffer_read(buf, buffer_string); // Corrected usage

    // Delete the buffer after reading
    buffer_delete(buf);

    // Parse JSON string into a struct/array
    var jsonData = json_parse(jsonString);
    return jsonData;
}
