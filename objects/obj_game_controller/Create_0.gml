/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 2087F42E
/// @DnDArgument : "code" "// obj_game_controller Create Event$(13_10)$(13_10)// Initialize game position arrays first$(13_10)block_x_positions_by_row_length = {$(13_10)    len4: [375, 465, 555, 645],$(13_10)    len5: [330, 420, 510, 600, 690],$(13_10)    len6: [285, 375, 465, 555, 645, 735],$(13_10)    len7: [240, 330, 420, 510, 600, 690, 780],$(13_10)    len8: [195, 285, 375, 465, 555, 645, 735, 825],$(13_10)    len9: [150, 240, 330, 420, 510, 600, 690, 780, 870],$(13_10)    len10: [195, 285, 375, 465, 555, 645, 735, 825, 915, 1005]$(13_10)};$(13_10)$(13_10)block_y_position_by_level = {$(13_10)    lev1: [375,465,555,645],$(13_10)    lev2: [330,420,510,600,690],$(13_10)    lev3: [285,375,465,555,645,735],$(13_10)    lev4: [240,330,420,510,600,690,780],$(13_10)    lev5: [195,285,375,465,555,645,735,825],$(13_10)    lev6: [150,240,330,420,510,600,690,780,870],$(13_10)    lev7: [195,285,375,465,555,645,735,825,915,1005]$(13_10)};$(13_10)$(13_10)// Game state variables$(13_10)current_level = 1;$(13_10)current_row_length = 4; // Starts with 4-letter words$(13_10)current_word = "";$(13_10)active_blocks = ds_list_create(); // Keep track of movable blocks$(13_10)$(13_10)// Define all functions first$(13_10)function get_level_word(word_length) {$(13_10)    show_debug_message("Getting word for length: " + string(word_length));$(13_10)    $(13_10)    // Access the word list using variable_struct_get$(13_10)    var word_list = variable_struct_get(global.wordOrder, string(word_length));$(13_10)    $(13_10)    if (word_list == undefined) {$(13_10)        show_debug_message("ERROR: No words found for length " + string(word_length));$(13_10)        return "TEST"; // Fallback word for testing$(13_10)    }$(13_10)    $(13_10)    show_debug_message("Word list for length " + string(word_length) + ": " + string(word_list));$(13_10)    $(13_10)    var word_found = false;$(13_10)    var selected_word = "";$(13_10)    $(13_10)    // Loop through words until we find an unused one$(13_10)    for (var i = 0; i < array_length(word_list); i++) {$(13_10)        var test_word = word_list[i];$(13_10)        if (variable_struct_get(global.wordArray, test_word) == 0) {$(13_10)            selected_word = test_word;$(13_10)            word_found = true;$(13_10)            break;$(13_10)        }$(13_10)    }$(13_10)    $(13_10)    // If no unused words, reset and take first word$(13_10)    if (!word_found) {$(13_10)        var first_word = word_list[0];$(13_10)        // Reset all words of this length$(13_10)        for (var i = 0; i < array_length(word_list); i++) {$(13_10)            variable_struct_set(global.wordArray, word_list[i], 0);$(13_10)        }$(13_10)        selected_word = first_word;$(13_10)    }$(13_10)    $(13_10)    // Mark word as used$(13_10)    variable_struct_set(global.wordArray, selected_word, 1);$(13_10)    show_debug_message("Selected word: " + selected_word);$(13_10)    return selected_word;$(13_10)}$(13_10)$(13_10)function create_pyramid_blocks() {$(13_10)    var x_positions = variable_struct_get(block_x_positions_by_row_length, $(13_10)                                        "len" + string(current_row_length));$(13_10)    var y_positions = variable_struct_get(block_y_position_by_level,$(13_10)                                        "lev" + string(current_level));$(13_10)    $(13_10)    show_debug_message("Creating blocks for word: " + current_word);$(13_10)    show_debug_message("Current row length: " + string(current_row_length));$(13_10)    $(13_10)    // Create base row letters$(13_10)    for(var i = 0; i < string_length(current_word); i++) {$(13_10)        var current_letter = string_char_at(current_word, i + 1);$(13_10)        show_debug_message("Creating letter: " + current_letter + " at position " + string(i));$(13_10)        $(13_10)        // Create ghost letter (non-draggable, semi-transparent)$(13_10)        var ghost = instance_create_layer(x_positions[i], y_positions[0], $(13_10)                                        "blocks_and_letters", obj_letters);$(13_10)        ghost.letter = current_letter;$(13_10)        ghost.image_index = ord(ghost.letter) - ord("A") + 1; // +1 because sprite starts at 1$(13_10)        ghost.image_speed = 0; // Stop animation$(13_10)        ghost.image_alpha = 0.5;$(13_10)        ghost.is_ghost = true;$(13_10)        ghost.original_x = x_positions[i];$(13_10)        ghost.original_y = y_positions[0];$(13_10)        ghost.row = 0;$(13_10)        ghost.col = i;$(13_10)        $(13_10)        // Create draggable letter$(13_10)        var letter = instance_create_layer(x_positions[i], y_positions[0], $(13_10)                                         "blocks_and_letters", obj_letters);$(13_10)        letter.letter = current_letter;$(13_10)        letter.image_index = ord(letter.letter) - ord("A") + 1;$(13_10)        letter.image_speed = 0; // Stop animation$(13_10)        letter.is_ghost = false;$(13_10)        letter.original_x = x_positions[i];$(13_10)        letter.original_y = y_positions[0];$(13_10)        letter.row = 0;$(13_10)        letter.col = i;$(13_10)        letter.ghost_reference = ghost;$(13_10)        $(13_10)        ds_list_add(active_blocks, letter);$(13_10)    }$(13_10)}$(13_10)$(13_10)function clear_level() {$(13_10)    if (object_exists(obj_letters)) {$(13_10)        with(obj_letters) instance_destroy();$(13_10)    }$(13_10)    ds_list_clear(active_blocks);$(13_10)}$(13_10)$(13_10)function initialize_level(level) {$(13_10)    clear_level();$(13_10)    current_row_length = level + 3;$(13_10)    current_word = get_level_word(current_row_length);$(13_10)    show_debug_message("Selected word: " + current_word);$(13_10)    create_pyramid_blocks();$(13_10)}$(13_10)$(13_10)function initialize_game() {$(13_10)    initialize_level(current_level);$(13_10)}$(13_10)$(13_10)// Just debug message, no initialization call$(13_10)show_debug_message("Game controller initialized");"
// obj_game_controller Create Event

// Initialize game position arrays first
block_x_positions_by_row_length = {
    len4: [375, 465, 555, 645],
    len5: [330, 420, 510, 600, 690],
    len6: [285, 375, 465, 555, 645, 735],
    len7: [240, 330, 420, 510, 600, 690, 780],
    len8: [195, 285, 375, 465, 555, 645, 735, 825],
    len9: [150, 240, 330, 420, 510, 600, 690, 780, 870],
    len10: [195, 285, 375, 465, 555, 645, 735, 825, 915, 1005]
};

block_y_position_by_level = {
    lev1: [375,465,555,645],
    lev2: [330,420,510,600,690],
    lev3: [285,375,465,555,645,735],
    lev4: [240,330,420,510,600,690,780],
    lev5: [195,285,375,465,555,645,735,825],
    lev6: [150,240,330,420,510,600,690,780,870],
    lev7: [195,285,375,465,555,645,735,825,915,1005]
};

// Game state variables
current_level = 1;
current_row_length = 4; // Starts with 4-letter words
current_word = "";
active_blocks = ds_list_create(); // Keep track of movable blocks

// Define all functions first
function get_level_word(word_length) {
    show_debug_message("Getting word for length: " + string(word_length));
    
    // Access the word list using variable_struct_get
    var word_list = variable_struct_get(global.wordOrder, string(word_length));
    
    if (word_list == undefined) {
        show_debug_message("ERROR: No words found for length " + string(word_length));
        return "TEST"; // Fallback word for testing
    }
    
    show_debug_message("Word list for length " + string(word_length) + ": " + string(word_list));
    
    var word_found = false;
    var selected_word = "";
    
    // Loop through words until we find an unused one
    for (var i = 0; i < array_length(word_list); i++) {
        var test_word = word_list[i];
        if (variable_struct_get(global.wordArray, test_word) == 0) {
            selected_word = test_word;
            word_found = true;
            break;
        }
    }
    
    // If no unused words, reset and take first word
    if (!word_found) {
        var first_word = word_list[0];
        // Reset all words of this length
        for (var i = 0; i < array_length(word_list); i++) {
            variable_struct_set(global.wordArray, word_list[i], 0);
        }
        selected_word = first_word;
    }
    
    // Mark word as used
    variable_struct_set(global.wordArray, selected_word, 1);
    show_debug_message("Selected word: " + selected_word);
    return selected_word;
}

function create_pyramid_blocks() {
    var x_positions = variable_struct_get(block_x_positions_by_row_length, 
                                        "len" + string(current_row_length));
    var y_positions = variable_struct_get(block_y_position_by_level,
                                        "lev" + string(current_level));
    
    show_debug_message("Creating blocks for word: " + current_word);
    show_debug_message("Current row length: " + string(current_row_length));
    
    // Create base row letters
    for(var i = 0; i < string_length(current_word); i++) {
        var current_letter = string_char_at(current_word, i + 1);
        show_debug_message("Creating letter: " + current_letter + " at position " + string(i));
        
        // Create ghost letter (non-draggable, semi-transparent)
        var ghost = instance_create_layer(x_positions[i], y_positions[0], 
                                        "blocks_and_letters", obj_letters);
        ghost.letter = current_letter;
        ghost.image_index = ord(ghost.letter) - ord("A") + 1; // +1 because sprite starts at 1
        ghost.image_speed = 0; // Stop animation
        ghost.image_alpha = 0.5;
        ghost.is_ghost = true;
        ghost.original_x = x_positions[i];
        ghost.original_y = y_positions[0];
        ghost.row = 0;
        ghost.col = i;
        
        // Create draggable letter
        var letter = instance_create_layer(x_positions[i], y_positions[0], 
                                         "blocks_and_letters", obj_letters);
        letter.letter = current_letter;
        letter.image_index = ord(letter.letter) - ord("A") + 1;
        letter.image_speed = 0; // Stop animation
        letter.is_ghost = false;
        letter.original_x = x_positions[i];
        letter.original_y = y_positions[0];
        letter.row = 0;
        letter.col = i;
        letter.ghost_reference = ghost;
        
        ds_list_add(active_blocks, letter);
    }
}

function clear_level() {
    if (object_exists(obj_letters)) {
        with(obj_letters) instance_destroy();
    }
    ds_list_clear(active_blocks);
}

function initialize_level(level) {
    clear_level();
    current_row_length = level + 3;
    current_word = get_level_word(current_row_length);
    show_debug_message("Selected word: " + current_word);
    create_pyramid_blocks();
}

function initialize_game() {
    initialize_level(current_level);
}

// Just debug message, no initialization call
show_debug_message("Game controller initialized");