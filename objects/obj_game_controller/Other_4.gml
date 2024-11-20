//// obj_game_controller Room Start Event
//show_debug_message("Room Start Event - Current Room: " + room_get_name(room));

//// Reinitialize data structures if needed
//if (!initialized) {
//    try {
//        active_words = ds_map_create();
//        required_words = ds_map_create();
//        active_blocks = ds_list_create();
//        initialized = true;
//        show_debug_message("Reinitialized data structures");
//    } catch(error) {
//        show_debug_message("Error reinitializing data structures: " + string(error));
//    }
//}

//if (room == rm_loading) {
//    game_active = false;
//    timer_active = false;
//} else if (room == rm_menu) {
//    game_active = false;
//    timer_active = false;
//    current_score = 0;
//    time_remaining = 180;
//} else if (room == rm_game) {
//    show_debug_message("Game room entered - Mode: " + 
//                      (game_mode == GameMode.CASUAL ? "Casual" : "Timed"));
//}

//function room_start() {
//    show_debug_message("Room Start Event - Current Room: " + room_get_name(room));
    
//    if (room == rm_game) {
//        show_debug_message("In rm_game - Checking for game controller");
        
//        // Check if we're the only game controller
//        var controller_count = instance_number(obj_game_controller);
//        if (controller_count > 1) {
//            show_debug_message("Multiple controllers found - destroying duplicate");
//            instance_destroy();
//            return;
//        }
        
//        show_debug_message("Initializing game in rm_game");
//        if (!layer_exists("blocks_and_letters")) {
//            show_debug_message("ERROR: blocks_and_letters layer missing");
//            layer_create(100, "blocks_and_letters");
//        }
//        if (!layer_exists("UI")) {
//            show_debug_message("ERROR: UI layer missing");
//            layer_create(0, "UI");
//        }
        
//        // Initialize the game
//        initialize_game();
//    } else {
//        show_debug_message("Room Start in different room: " + room_get_name(room));
//    }
//}


//function room_start() {
//    show_debug_message("Room Start Event - Current Room: " + room_get_name(room));
    
//    if (room == rm_game) {
//        show_debug_message("In rm_game - Checking for game controller");
        
//        // Check if we're the only game controller
//        var controller_count = instance_number(obj_game_controller);
//        if (controller_count > 1) {
//            show_debug_message("Multiple controllers found - destroying duplicate");
//            instance_destroy();
//            return;
//        }
        
//        show_debug_message("Initializing game in rm_game");
//        if (!layer_exists("blocks_and_letters")) {
//            show_debug_message("ERROR: blocks_and_letters layer missing");
//            layer_create(100, "blocks_and_letters");
//        }
//        if (!layer_exists("UI")) {
//            show_debug_message("ERROR: UI layer missing");
//            layer_create(0, "UI");
//        }
        
//        // Initialize the game
//        initialize_game();
//    } else {
//        show_debug_message("Room Start in different room: " + room_get_name(room));
//    }
//}

//// Add to obj_game_controller
//function check_word_formation() {
//    // Get all letters in each row
//    var max_rows = current_row_length - 1;
    
//    for(var row = 0; row < max_rows; row++) {
//        var word = "";
//        var letter_positions = ds_list_create();
//        var letter_instances = ds_list_create();
        
//        // Find all letters in this row
//        with(obj_letters) {
//            if (!is_ghost && self.row == row) {
//                ds_list_add(letter_positions, {
//                    letter: letter,
//                    col: col,
//                    instance: id
//                });
//            }
//        }
        
//        // Sort letters by column to form word left to right
//        for(var i = 0; i < ds_list_size(letter_positions); i++) {
//            for(var j = i + 1; j < ds_list_size(letter_positions); j++) {
//                if (letter_positions[| j].col < letter_positions[| i].col) {
//                    var temp = letter_positions[| i];
//                    letter_positions[| i] = letter_positions[| j];
//                    letter_positions[| j] = temp;
//                }
//            }
//        }
        
//        // Construct word from sorted letters
//        for(var i = 0; i < ds_list_size(letter_positions); i++) {
//            word += letter_positions[| i].letter;
//            ds_list_add(letter_instances, letter_positions[| i].instance);
//        }
        
//        // If we have a complete word for this row
//        if (string_length(word) == current_row_length - row - 1) {
//            validate_word(word, row, letter_instances);
//        }
        
//        ds_list_destroy(letter_positions);
//        ds_list_destroy(letter_instances);
//    }
//}

//function validate_word(word, row, letter_instances) {
//    word = string_upper(word);
//    var word_struct = variable_struct_get(global.wordObj, string_length(word));
    
//    if (word_struct != undefined && variable_struct_exists(word_struct, word)) {
//        // Word is valid!
//        var word_data = variable_struct_get(word_struct, word);
//        var is_unused = variable_struct_get(global.wordArray, word) == 0;
        
//        // Calculate score
//        if (is_unused) {
//            // Mark word as used
//            variable_struct_set(global.wordArray, word, 1);
            
//            // Calculate score
//            var base_points = string_length(current_word) * 5;
//            var anas_found = count_found_anas(word_data.anas);
//            var anas_total = array_length(word_data.anas);
//            var anas_multiplier = anas_found / anas_total;
            
//            var points = base_points * anas_multiplier;
//			global.current_score += points;
            
//            // Add time bonus
//            time_remaining += string_length(current_word) * 10;
            
//            // Create ghost letters and flash green
//            for(var i = 0; i < ds_list_size(letter_instances); i++) {
//                var letter_inst = letter_instances[| i];
//                letter_inst.flash_alpha = 1;
//                letter_inst.flash_color = c_green;
                
//                // Create ghost letter
//                var ghost = instance_create_layer(letter_inst.x, letter_inst.y, 
//                                                "blocks_and_letters", obj_letters);
//                ghost.letter = letter_inst.letter;
//                ghost.image_index = letter_inst.image_index;
//                ghost.image_speed = 0;
//                ghost.is_ghost = true;
//                ghost.image_alpha = 0.5;
//                ghost.row = letter_inst.row;
//                ghost.col = letter_inst.col;
//            }
            
//            // Remove or fade unused letters from previous row
//            with(obj_letters) {
//                if (!is_ghost && row == (other.row - 1)) {
//                    instance_destroy();
//                }
//            }
//        }
//    } else {
//        // Invalid word - flash red
//        for(var i = 0; i < ds_list_size(letter_instances); i++) {
//            var letter_inst = letter_instances[| i];
//            letter_inst.flash_alpha = 1;
//            letter_inst.flash_color = c_red;
//        }
//    }
//}

//function count_found_anas(anas_array) {
//    var found_count = 0;
//    for(var i = 0; i < array_length(anas_array); i++) {
//        if (variable_struct_get(global.wordArray, anas_array[i]) == 1) {
//            found_count++;
//        }
//    }
//    return found_count;
//}