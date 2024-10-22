/// @description Insert description here
// You can write your code in this editor
// Initialize the global game state
global.game_state = "menu";  // Default state (e.g., main menu)

// Initialize other global variables if needed
global.player_score = 0;

/// @function load_csv(filename)
/// @description Loads and parses a CSV file into a 2D array.
/// @param filename The path to the CSV file (e.g., "datafiles/1.csv").
function load_csv(filename) {
    // Open the file for reading
    var file = file_text_open_read(filename);
    var result = [];
    
    // Ensure the file was opened successfully
    if (file != -1) {
        // Loop through the file and read each line
        while (!file_text_eof(file)) {
            var line = file_text_read_string(file);  // Read a line of the CSV
            file_text_readln(file);  // Move to the next line
            
            // Split the line into individual elements by commas
            var elements = string_split(line, ",");
            
            // Add the parsed elements to the result array
            array_push(result, elements);
        }

        // Close the file
        file_text_close(file);
    } else {
        show_debug_message("Error: Unable to open the file!");
    }
    
    return result;  // Return the parsed data as a 2D array
}

// Load the CSV file into a 2D array
var words3 = load_csv("datafiles/3.csv");

// Check the contents of the first row/column
if (array_length(words3) > 0) {
    show_debug_message("First row, first element: " + words1[0][0]);
} 



var _file = file_text_open_write("temp");
file_text_close(_file);