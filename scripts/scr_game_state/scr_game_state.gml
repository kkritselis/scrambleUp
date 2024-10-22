show_debug_message("Game State Script running");

var file_path = working_directory + "4.csv";  // Or "test.csv" if you're testing
var words1 = load_csv(file_path);
show_debug_message("CSV file directoy:"+ working_directory);

if (array_length(words1) > 0) {
    // Loop through the array and display its contents
    for (var i = 0; i < array_length(words1); i++) {
        var row_data = words1[i];  // Get each row (which is itself an array)
        var row_string = "";  // Initialize an empty string to build the row data
        
        // Loop through each element in the row
        for (var j = 0; j < array_length(row_data); j++) {
            row_string += row_data[j] + " ";  // Append each element to the row string
        }
        
        // Display the row
        show_debug_message("Row " + string(i) + ": " + row_string);
    }
} else {
    show_debug_message("CSV file is empty or not loaded.");
}