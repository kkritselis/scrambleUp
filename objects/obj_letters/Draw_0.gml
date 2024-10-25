draw_self();

// Draw flash effect if active
if (flash_alpha > 0) {
    gpu_set_blendmode(bm_add);
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 
                   image_angle, flash_color, flash_alpha);
    gpu_set_blendmode(bm_normal);
}

// Helper function to check if position is valid
function check_valid_position() {
    var game_ctrl = instance_nearest(0, 0, obj_game_controller);
    var target_row = row + 1;
    var x_positions = variable_struct_get(game_ctrl.block_x_positions_by_row_length, 
                                        "len" + string(game_ctrl.current_row_length - target_row));
    var y_positions = variable_struct_get(game_ctrl.block_y_position_by_level,
                                        "lev" + string(game_ctrl.current_level));
    
    // Check each possible position in the row above
    for(var i = 0; i < array_length(x_positions); i++) {
        var check_x = x_positions[i];
        var check_y = y_positions[target_row];
        
        if (point_in_rectangle(mouse_x, mouse_y, 
                             check_x, check_y,
                             check_x + sprite_width, check_y + sprite_height)) {
            // Check if position is already occupied
            var occupied = false;
            with(obj_letters) {
                if (!is_ghost && row == target_row && col == i) {
                    occupied = true;
                    break;
                }
            }
            
            if (!occupied) {
                return {
                    x: check_x,
                    y: check_y,
                    row: target_row,
                    col: i
                };
            }
        }
    }
    
    return noone;
}