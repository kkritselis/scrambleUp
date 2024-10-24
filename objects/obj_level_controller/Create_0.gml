/// @description Insert description here
// You can write your code in this editor
// In the Create Event of obj_level_controller or any appropriate object
var four_letter_struct = variable_struct_get(global.wordObj, 4); // Safely access the struct "4"

if (four_letter_struct != undefined && is_struct(four_letter_struct)) {
    show_debug_message("Four-letter struct loaded.");
    
    var keys = variable_struct_get_names(four_letter_struct);
    if (array_length(keys) > 0) {
        global.selected_word = keys[0]; // Store the selected word globally
        show_debug_message("Selected word: " + global.selected_word);

        // Access the struct associated with the selected word
        var word_struct = variable_struct_get(four_letter_struct, global.selected_word);
        
        if (word_struct != undefined && is_struct(word_struct)) {
            global.anagrams = word_struct.anas; // Store the anagrams globally
        }
    }
}