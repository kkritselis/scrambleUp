if (!is_ghost) {
    if (is_dragging) {
        x = mouse_x - drag_offset_x;
        y = mouse_y - drag_offset_y;
        
        // Check for mouse release
        if (!mouse_check_button(mb_left)) {
            show_debug_message("Letter " + letter + " dropped");
            is_dragging = false;
            depth = 0;
            
            var valid_drop = false;
            var controller = instance_find(obj_game_controller, 0);
            
            if (controller != noone) {
                var target_row = row + 1; // Row above current position
                var dropping_back = false;
                
                // Check if dropping back to original position
                if (point_in_rectangle(mouse_x, mouse_y, 
                                    original_x - sprite_width/2, original_y - sprite_height/2,
                                    original_x + sprite_width/2, original_y + sprite_height/2)) {
                    x = original_x;
                    y = original_y;
                    row = 0;
                    col = original_col;
                    valid_drop = true;
                    dropping_back = true;
                } else {
                    // Get positions for target row
                    var row_length_key = "len" + string(controller.current_row_length - target_row);
                    var level_key = "lev" + string(controller.current_level);
                    
                    if (variable_struct_exists(controller.block_x_positions_by_row_length, row_length_key)) {
                        var x_positions = controller.block_x_positions_by_row_length[$ row_length_key];
                        var y_positions = controller.block_y_position_by_level[$ level_key];
                        
                        // Check each position in the target row
                        for (var i = 0; i < array_length(x_positions); i++) {
                            if (point_in_rectangle(mouse_x, mouse_y,
                                                x_positions[i] - sprite_width/2, 
                                                y_positions[target_row] - sprite_height/2,
                                                x_positions[i] + sprite_width/2,
                                                y_positions[target_row] + sprite_height/2)) {
                                                
                                // Check if position is already occupied
                                var position_occupied = false;
                                with(obj_letters) {
                                    if (!is_ghost && row == target_row && col == i) {
                                        position_occupied = true;
                                        break;
                                    }
                                }
                                
                                if (!position_occupied) {
                                    x = x_positions[i];
                                    y = y_positions[target_row];
                                    row = target_row;
                                    col = i;
                                    valid_drop = true;
                                    break;
                                }
                            }
                        }
                    }
                }
                
                // If valid drop and not returning to original position, check word formation
                if (valid_drop && !dropping_back) {
                    with(controller) {
                        check_word_formation();
                    }
                }
            }
            
            // Return to original position if drop wasn't valid
            if (!valid_drop) {
                x = original_x;
                y = original_y;
                row = 0;
                col = original_col;
            }
            
        }
    } else if (position_meeting(mouse_x, mouse_y, id) && mouse_check_button_pressed(mb_left)) {
        is_dragging = true;
        depth = -1000;
        drag_offset_x = mouse_x - x;
        drag_offset_y = mouse_y - y;
    }
}
