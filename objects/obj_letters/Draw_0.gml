draw_self();

if (flash_alpha > 0) {
    flash_alpha -= 0.1;
    gpu_set_blendmode(bm_add);
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 
                   image_angle, flash_color, flash_alpha);
    gpu_set_blendmode(bm_normal);
}


// Debug: Draw drop zones when dragging (remove this section for production)
if (is_dragging) {
    var controller = instance_find(obj_game_controller, 0);
    if (controller != noone) {
        var target_row = row + 1;
        var row_length_key = "len" + string(controller.current_row_length - target_row);
        var level_key = "lev" + string(controller.current_level);
        
        if (variable_struct_exists(controller.block_x_positions_by_row_length, row_length_key)) {
            var x_positions = controller.block_x_positions_by_row_length[$ row_length_key];
            var y_positions = controller.block_y_position_by_level[$ level_key];
            
            if (target_row < array_length(y_positions)) {
                var target_y = y_positions[target_row];
                
                for(var i = 0; i < array_length(x_positions); i++) {
                    draw_set_alpha(0.3);
                    draw_rectangle(
                        x_positions[i] - sprite_width/2,
                        target_y - sprite_height/2,
                        x_positions[i] + sprite_width/2,
                        target_y + sprite_height/2,
                        true
                    );
                    draw_set_alpha(1);
                }
            }
        }
    }
}