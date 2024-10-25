function validateWord(word_string) {
    if (variable_struct_exists(global.wordArray, word_string)) {
        if (global.wordArray[word_string] == 0) {
            return true;  // Word is valid and has not been used yet
        } else {
            return "used";  // Word is valid but already used
        }
    } else {
        return false;  // Word is not valid
    }
}