// Create Event

if (!variable_instance_exists(id, "frame_index")) {
    frame_index = 0;  // Default to 0 ("A") if frame_index is not passed
}


image_index = frame_index;  // Set the sprite frame to the correct letter (passed when the object is created)
image_speed = 0;

dragging = false;  // Is the letter being dragged?
locked = false; 
drag_offset_x = 0;  // Offset from the mouse position when dragging
drag_offset_y = 0;
original_x = x;  // Store the original position
original_y = y;

depth = 5;  // Lower depth value for the letters to be on top of the frame
