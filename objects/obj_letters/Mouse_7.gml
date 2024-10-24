// Mouse Up Event
if (dragging) {
    dragging = false;
	depth = 5;
    // Check for collision with the drop blocks (obj_block)
    var target_block = instance_place(mouse_x, mouse_y, obj_block);
    
    if (target_block != noone) {
        // Snap to the block position
        x = target_block.x;
        y = target_block.y;
		locked = true;
    } else {
        // If not dropped on a block, return to the original position
        x = original_x;
        y = original_y;
    }
}