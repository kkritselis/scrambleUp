// Use variable_struct_get to access the key "4" in global.wordObj
var four_letter_struct = variable_struct_get(global.wordObj, 4); // Safely access the struct "4"

// Check if four_letter_struct exists and is a struct
if (four_letter_struct != undefined && is_struct(four_letter_struct)) {
    show_debug_message("Four-letter struct loaded.");
    
    // Extract all the word keys in the struct (e.g., "abet")
    var keys = variable_struct_get_names(four_letter_struct);
    if (array_length(keys) > 0) {
        var selected_word = keys[0]; // In this case, the word is "abet"
        show_debug_message("Selected word: " + selected_word);

        // Access the struct associated with the word (e.g., "abet")
        var word_struct = variable_struct_get(four_letter_struct, selected_word);
        
        // Check if the word struct is valid and contains an array of anagrams
        if (word_struct != undefined && is_struct(word_struct)) {
            var anagrams = word_struct.anas; // Access the "anas" array directly

            // Check if anagrams is a valid array
            if (is_array(anagrams)) {
                show_debug_message("Anagrams array loaded for word: " + selected_word);
                
                // Loop through the anagrams and print them
                for (var i = 0; i < array_length(anagrams); i++) {
                    show_debug_message("Anagram [" + string(i) + "]: " + anagrams[i]);
                }

                // Now, you could perform additional operations such as drawing letters
                // Example: Drawing the letters of the selected word
                for (var i = 0; i < string_length(selected_word); i++) {
                    var letter = string_char_at(selected_word, i);
                    show_debug_message("Letter: " + letter);
                }
            } else {
                show_debug_message("Anagrams array is empty or not found.");
            }
        } else {
            show_debug_message("Word struct for " + selected_word + " is invalid.");
        }
    } else {
        show_debug_message("No word keys found in the four-letter struct.");
    }
} else {
    show_debug_message("Four-letter struct not valid or undefined.");
}