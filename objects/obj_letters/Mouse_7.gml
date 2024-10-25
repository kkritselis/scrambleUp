// Mouse Up Event
if (dragging) {
    dragging = false;
    depth = 5;

    // Check for collision with the drop blocks (obj_block)
    var target_block = instance_place(mouse_x, mouse_y, obj_block);

    if (target_block != noone) {
        // Snap to the block position
        if (!target_block.occupied) {
            x = target_block.x;
            y = target_block.y;
            
            target_block.occupied = true;  // Mark the new block as occupied
			target_block.letter_instance = id;  // Store a reference to the letter instance
            if (original_block != noone) {
                original_block.occupied = false;  // Unmark the original block
            }

            original_block = target_block;  // Update the original block reference
			// When the letter is placed in the new block

        } else {
            // Target block is occupied, return to original position
            x = original_x;
            y = original_y;
        }
    } else {
        // Not dropped on a valid block, return to original position
        x = original_x;
        y = original_y;
    }
}