// Mouse Down Event
if (mouse_check_button_pressed(mb_left)) {
    dragging = true;
    drag_offset_x = x - mouse_x;  // Calculate the offset
    drag_offset_y = y - mouse_y;
}