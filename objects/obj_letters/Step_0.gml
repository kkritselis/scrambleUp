if (!is_ghost) {
    if (is_dragging) {
        x = mouse_x - sprite_width/2;
        y = mouse_y - sprite_height/2;
        
        // Check for mouse release
        if (!mouse_check_button(mb_left)) {
            is_dragging = false;
            
            // Check if over valid position and snap or return
            var valid_pos = check_valid_position();
            if (valid_pos != noone) {
                x = valid_pos.x;
                y = valid_pos.y;
                row = valid_pos.row;
                col = valid_pos.col;
                
                // Check if word is formed
                with(obj_game_controller) {
                    check_word_formation();
                }
            } else {
                x = original_x;
                y = original_y;
            }
        }
    } else if (position_meeting(mouse_x, mouse_y, id) && mouse_check_button_pressed(mb_left)) {
        is_dragging = true;
        // Bring to front
        depth = -1000;
    }
}

// Flash effect handling
if (flash_alpha > 0) {
    flash_alpha -= 0.1;
}