draw_set_alpha(alpha);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Draw semi-transparent background
draw_set_color(c_black);
draw_set_alpha(0.7);
draw_rectangle(0, 0, room_width, room_height, false);

// Draw game over text
draw_set_alpha(alpha);
draw_set_color(c_white);
draw_text(x, y - 40, "Time's Up!");
draw_text(x, y, "Final Score: " + string(final_score));
draw_text(x, y + 40, "Returning to Menu...");

// Reset drawing properties
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);