// // Call this function when the game ends or the player finishes a level
// function saveProgress() {
//     ini_open("saved_progress.ini");

//     var keys_array = variable_struct_get_names(global.wordArray);  // Get array of keys from wordArray
//     var num_keys = array_length(keys_array);  // Use array_length to get the number of keys

//     for (var i = 0; i < num_keys; i++) {
//         var key = keys_array[i];  // Access each key
//         ini_write_real("Words", key, global.wordArray[? key]);  // Save each word's status
//     }

//     ini_close();
// }

// // Example Game Over function
// function gameOver() {
//     saveProgress();  // Save the progress when the game ends
//     // Show a simple alert or message to the player
//     show_message("Game Over! Returning to menu...");
//     room_goto(rm_menu);  // Return to the menu
// }