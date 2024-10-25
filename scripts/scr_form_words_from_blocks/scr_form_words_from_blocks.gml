function formWordFromBlocks() {
    var word_string = "";
    
    // Loop through each block in the global.blocks_in_row array
    for (var i = 0; i < array_length(global.blocks_in_row); i++) {
        var block = global.blocks_in_row[i];
        
        // Check if the block has a letter on it (if occupied or however you define it)
        if (block.occupied) {
            // Assuming the block has a reference to the letter object on it, get the letter from it
            var letter_instance = block.letter_instance;
            
            // Convert the `image_index` to a letter (assuming `image_index` maps to the correct letter)
            var letter = chr(ord("A") + letter_instance.image_index - 1);  // Adjust according to your sprite frame indexing
            
            // Append the letter to the word string
            word_string += letter;
        }
    }

    return word_string;  // Return the final word string
}