// Access the "4" key in global.wordObj
var four_letter_struct = variable_struct_get(global.wordObj, 4);

// Check if the four-letter struct exists and is valid
if (four_letter_struct != undefined && is_struct(four_letter_struct)) {
    
    // Extract the first word key in the struct (e.g., "agar")
    var keys = variable_struct_get_names(four_letter_struct);
    if (array_length(keys) > 0) {
        var selected_word = keys[0]; // First word in the struct

        // Check if selected_word is a valid string
        if (is_string(selected_word)) {

            // Base x and y coordinates for the blocks
            var base_x = 470;
            var base_y = 945;
            var block_size = 90;

            // Loop through each letter in the selected word (start from 1 for string_char_at)
            for (var i = 1; i <= string_length(selected_word); i++) {
                var letter = string_char_at(selected_word, i);  // Get each letter
                
                // Convert the letter to uppercase for sprite index calculation
                var uppercase_letter = string_upper(letter);

                // Find the corresponding frame in your sprite sheet for the letter
                var frame_index = ord(uppercase_letter) - ord("A");

                // Ensure the frame index is valid and draw the sprite
                if (frame_index >= 1 && frame_index <= 26) {
                    var x_pos = base_x + ((i - 1) * block_size);  // Position each block
                    var y_pos = base_y;
                    draw_sprite(spr_letters, frame_index, x_pos, y_pos);
                }
            }
        }
    }
}