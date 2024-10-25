function calculateScore(base_word_length, word_string) {
    var anagrams_found = 0;
    var total_anagrams = array_length(global.wordObj[word_string].anas);

    // Calculate how many anagrams have already been found
    for (var i = 0; i < total_anagrams; i++) {
        if (global.wordArray[global.wordObj[word_string].anas[i]] == 1) {
            anagrams_found++;
        }
    }

    // Calculate the score
    var calculated_score = (base_word_length * 5) * (1 - (anagrams_found / total_anagrams));
    return calculated_score;
}