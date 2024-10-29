// // scr_game_functions

// function get_level_word(word_length) {
//     show_debug_message("Getting word for length: " + string(word_length));
    
//     // Access the word list using variable_struct_get
//     var word_list = variable_struct_get(global.wordOrder, string(word_length));
    
//     if (word_list == undefined) {
//         show_debug_message("ERROR: No words found for length " + string(word_length));
//         return "TEST"; // Fallback word for testing
//     }
    
//     show_debug_message("Word list for length " + string(word_length) + ": " + string(word_list));
    
//     var word_found = false;
//     var selected_word = "";
    
//     // Loop through words until we find an unused one
//     for (var i = 0; i < array_length(word_list); i++) {
//         var test_word = word_list[i];
//         if (variable_struct_get(global.wordArray, test_word) == 0) {
//             selected_word = test_word;
//             word_found = true;
//             break;
//         }
//     }
    
//     // If no unused words, reset and take first word
//     if (!word_found) {
//         var first_word = word_list[0];
//         // Reset all words of this length
//         for (var i = 0; i < array_length(word_list); i++) {
//             variable_struct_set(global.wordArray, word_list[i], 0);
//         }
//         selected_word = first_word;
//     }
    
//     // Mark word as used
//     variable_struct_set(global.wordArray, selected_word, 1);
//     show_debug_message("Selected word: " + selected_word);
//     return selected_word;
// }

// function create_pyramid_blocks() {
//     if (!layer_exists("blocks_and_letters")) {
//         show_debug_message("ERROR: Cannot create blocks - blocks_and_letters layer missing");
//         return;
//     }
    
//     var x_positions = variable_struct_get(block_x_positions_by_row_length, 
//                                         "len" + string(current_row_length));
//     var y_positions = variable_struct_get(block_y_position_by_level,
//                                         "lev" + string(current_level));
    
//     if (x_positions == undefined || y_positions == undefined) {
//         show_debug_message("ERROR: Invalid positions for current level/row length");
//         return;
//     }
    
//     show_debug_message("Creating blocks for word: " + current_word);
//     show_debug_message("Current row length: " + string(current_row_length));
    
//     // Create base row letters
//     for(var i = 0; i < string_length(current_word); i++) {
//         var current_letter = string_char_at(current_word, i + 1);
//         show_debug_message("Creating letter: " + current_letter + " at position " + string(i));
        
//         // Create ghost letter (non-draggable, semi-transparent)
//         var ghost = instance_create_layer(x_positions[i], y_positions[0], 
//                                         "blocks_and_letters", obj_letters);
//         ghost.letter = current_letter;
//         ghost.image_index = ord(ghost.letter) - ord("A") + 1;
//         ghost.image_speed = 0;
//         ghost.image_alpha = 0.5;
//         ghost.is_ghost = true;
//         ghost.original_x = x_positions[i];
//         ghost.original_y = y_positions[0];
//         ghost.row = 0;
//         ghost.col = i;
        
//         // Create draggable letter
//         var letter = instance_create_layer(x_positions[i], y_positions[0], 
//                                          "blocks_and_letters", obj_letters);
//         letter.letter = current_letter;
//         letter.image_index = ord(letter.letter) - ord("A") + 1;
//         letter.image_speed = 0;
//         letter.is_ghost = false;
//         letter.original_x = x_positions[i];
//         letter.original_y = y_positions[0];
//         letter.row = 0;
//         letter.col = i;
//         letter.ghost_reference = ghost;
        
//         ds_list_add(active_blocks, letter);
//     }
// }

// function clear_level() {
//     if (object_exists(obj_letters)) {
//         with(obj_letters) instance_destroy();
//     }
//     ds_list_clear(active_blocks);
// }

// function initialize_level(level) {
//     clear_level();
//     current_row_length = level + 3;
//     current_word = get_level_word(current_row_length);
//     show_debug_message("Selected word: " + current_word);
//     create_pyramid_blocks();
// }

// function initialize_game() {
//     initialize_level(current_level);
// }

// function check_word_formation() {
//     // Get all letters in each row
//     var max_rows = current_row_length - 1;
    
//     for(var row = 0; row < max_rows; row++) {
//         var word = "";
//         var letter_positions = ds_list_create();
        
//         // Find all letters in this row
//         with(obj_letters) {
//             if (!is_ghost && self.row == row) {
//                 ds_list_add(letter_positions, {
//                     letter: letter,
//                     col: col
//                 });
//             }
//         }
        
//         // Sort letters by column to form word left to right
//         for(var i = 0; i < ds_list_size(letter_positions); i++) {
//             for(var j = i + 1; j < ds_list_size(letter_positions); j++) {
//                 if (letter_positions[| j].col < letter_positions[| i].col) {
//                     var temp = letter_positions[| i];
//                     letter_positions[| i] = letter_positions[| j];
//                     letter_positions[| j] = temp;
//                 }
//             }
//         }
        
//         // Construct word from sorted letters
//         for(var i = 0; i < ds_list_size(letter_positions); i++) {
//             word += letter_positions[| i].letter;
//         }
        
//         // If we have a complete word for this row
//         if (string_length(word) == current_row_length - row - 1) {
//             validate_word(word, row);
//         }
        
//         ds_list_destroy(letter_positions);
//     }
// }

// function validate_word(word, row) {
//     word = string_upper(word);
//     var word_length = string_length(word);
//     var word_struct = variable_struct_get(global.wordObj, word_length);
    
//     if (word_struct != undefined) {
//         if (variable_struct_exists(word_struct, word)) {
//             // Word is valid!
//             if (!ds_map_exists(active_words, row) || active_words[? row] != word) {
//                 active_words[? row] = word;
                
//                 // Calculate and add score
//                 var points = calculate_word_score(word, row);
//                 current_score += points;
                
//                 // Create floating score text
//                 create_floating_score(points, row);
                
//                 flash_word(row, c_green);
//                 audio_play_sound(snd_word_valid, 1, false);
//                 check_level_completion();
//             }
//         } else {
//             // Invalid word
//             flash_word(row, c_red);
//             audio_play_sound(snd_word_invalid, 1, false);
//             combo_multiplier = 1; // Reset combo on invalid word
//             return_row_letters(row);
//         }
//     }
// }

// function flash_word(row, color) {
//     with(obj_letters) {
//         if (!is_ghost && self.row == row) {
//             flash_alpha = 1;
//             flash_color = color;
//         }
//     }
// }

// function return_row_letters(row) {
//     with(obj_letters) {
//         if (!is_ghost && self.row == row) {
//             x = original_x;
//             y = original_y;
//             row = 0;
//             col = original_col;
//         }
//     }
// }

// function check_level_completion() {
//     var words_needed = current_row_length - 3; // Number of rows we need to fill
//     var words_completed = ds_map_size(active_words);
    
//     if (words_completed >= words_needed) {
//         // Verify all words are valid combinations
//         var valid_pyramid = true;
//         var base_word = current_word;
        
//         for(var i = 0; i < words_needed; i++) {
//             if (!ds_map_exists(active_words, i)) {
//                 valid_pyramid = false;
//                 break;
//             }
            
//             var word = active_words[? i];
//             var valid_combinations = variable_struct_get(
//                 variable_struct_get(global.wordObj, string_length(word)),
//                 word
//             ).combinations;
            
//             if (!valid_combinations || !array_contains(valid_combinations, base_word)) {
//                 valid_pyramid = false;
//                 break;
//             }
            
//             base_word = word;
//         }
        
//         if (valid_pyramid) {
//             // Level complete!
//             current_level++;
//             if (current_level > max_level) {
//                 // Game complete!
//                 room_goto(rm_victory);
//             } else {
//                 // Start next level
//                 alarm[0] = 60; // Delay before next level
//             }
//         }
//     }
// }

// function calculate_word_score(word, row) {
//     var base_score = word_base_points;
    
//     // Longer words worth more
//     base_score += (string_length(word) - 3) * 50;
    
//     // Higher rows worth more
//     base_score += row * 75;
    
//     // Check combo timing
//     var _current_time = current_time/1000; // Convert to seconds
//     if (_current_time - last_word_time < combo_timeout) {
//         combo_multiplier += 0.5;
//     } else {
//         combo_multiplier = 1;
//     }
//     last_word_time = _current_time;
    
//     // Apply combo multiplier
//     var final_score = base_score * combo_multiplier;
    
//     return floor(final_score);
// }

// function create_floating_score(points, row) {
//     var x_pos = room_width/2;
//     var y_pos = room_height/2 - (row * 64);
    
//     with(instance_create_layer(x_pos, y_pos, "UI", obj_floating_score)) {
//         score_text = "+" + string(points);
//         if (other.combo_multiplier > 1) {
//             score_text += " x" + string(other.combo_multiplier);
//         }
//     }
// }

// function end_level(completed) {
//     timer_active = false;
//     show_debug_message("Level ending - completed: " + string(completed));
    
//     if (completed) {
//         // Level completion bonus
//         var time_bonus_points = floor(time_remaining) * time_bonus;
//         current_score += level_bonus + time_bonus_points;
        
//         // Show completion screen with bonuses
//         create_level_summary(time_bonus_points);
        
//         // Start next level after delay
//         alarm[0] = room_speed * 3;
//     } else {
//         // Time's up - handle game over
//         show_debug_message("Game Over - Time's up!");
        
//         // Create game over message
//         create_game_over_message();
        
//         // Return to menu after delay
//         alarm[1] = room_speed * 3;
//     }
// }

// function create_game_over_message() {
//     // Create a temporary object to display the game over message
//     with(instance_create_layer(room_width/2, room_height/2, "UI", obj_game_over_message)) {
//         final_score = other.current_score;
//     }
// }

// // Add this to handle returning to menu
// function return_to_menu() {
//     if (room_exists(rm_menu)) {
//         room_goto(rm_menu);
//     } else {
//         show_debug_message("ERROR: Menu room not found!");
//         game_restart();
//     }
// }