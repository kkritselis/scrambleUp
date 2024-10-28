draw_set_alpha(alpha);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(x, y - 40, "Level Complete!");
draw_text(x, y, "Time Bonus: +" + string(bonus_points));
draw_text(x, y + 40, "Total Score: " + string(total_score));
draw_set_alpha(1);