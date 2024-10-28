function scr_choose_word(length) {
    // Access the array using the '?' operator since the key is a string
    var _temp_word_array = global.wordOrder[? string(length)];

    // Check if the word array exists and is indeed an array
    if (!is_array(_temp_word_array)) {
        show_debug_message("Error: No words found for length " + string(length));
        return;
    }
    
    // Loop through each word in the array
    for (var i = 0; i < array_length(_temp_word_array); i++) {
        var word = _temp_word_array[i];
        var check = validateWord(word);
        if (check == false) {
            var selected_word = word;
            break;
        }
    }
    show_debug_message("selected word: " + selected_word);
}