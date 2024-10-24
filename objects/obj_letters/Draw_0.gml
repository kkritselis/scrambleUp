if (dragging) {
    draw_sprite(spr_letters, image_index, mouse_x + drag_offset_x, mouse_y + drag_offset_y);
} else {
    // If not dragging, draw it at its normal position
    draw_self();  // Draw the letter normally
}